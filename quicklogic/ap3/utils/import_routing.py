#!/usr/bin/env python3
import os
import itertools
import argparse
from collections import defaultdict
from collections import namedtuple
from collections import OrderedDict
import re

from data_structs import *
import lxml.etree as ET
from connections import hop_to_str, get_name_and_hop, is_regular_hop_wire

# =============================================================================

def update_switchbox_pins(switchbox):
    """
    Identifies top-level inputs and outputs of the switchbox and updates lists
    of them.
    """
    switchbox.inputs = {}
    switchbox.outputs = {}

    # Top-level inputs and their locations. Indexed by pin names.
    input_locs = defaultdict(lambda: [])

    for stage_id, stage in switchbox.stages.items():
        for switch_id, switch in stage.switches.items():
            for mux_id, mux in switch.muxes.items():

                # Add the mux output pin as top level output if necessary
                if mux.output.name is not None:
                    loc = SwitchboxPinLoc(
                        stage_id=stage.id,
                        switch_id=switch.id,
                        mux_id=mux.id,
                        pin_id=0,
                        pin_direction=PinDirection.OUTPUT
                    )

                    if stage.type == "STREET":
                        pin_type = SwitchboxPinType.LOCAL
                    else:
                        pin_type = SwitchboxPinType.HOP

                    pin = SwitchboxPin(
                        id=len(switchbox.outputs),
                        name=mux.output.name,
                        direction=PinDirection.OUTPUT,
                        locs=[loc],
                        type=pin_type
                    )

                    assert pin.name not in switchbox.outputs, pin
                    switchbox.outputs[pin.name] = pin

                # Add the mux input pins as top level inputs if necessary
                for pin in mux.inputs.values():
                    if pin.name is not None:
                        loc = SwitchboxPinLoc(
                            stage_id=stage.id,
                            switch_id=switch.id,
                            mux_id=mux.id,
                            pin_id=pin.id,
                            pin_direction=PinDirection.INPUT
                        )

                        input_locs[pin.name].append(loc)

    # Add top-level input pins to the switchbox.
    keys = sorted(input_locs.keys(), key=lambda k: k[0])
    for name, locs in {k: input_locs[k] for k in keys}.items():

        # Determine the pin type
        is_hop = is_regular_hop_wire(name)
        _, hop = get_name_and_hop(name)

        if name in ["VCC", "GND"]:
            pin_type = SwitchboxPinType.CONST
        elif name.startswith("CAND"):
            pin_type = SwitchboxPinType.GCLK
        elif is_hop:
            pin_type = SwitchboxPinType.HOP
        elif hop is not None:
            pin_type = SwitchboxPinType.FOREIGN
        else:
            pin_type = SwitchboxPinType.LOCAL

        pin = SwitchboxPin(
            id=len(switchbox.inputs),
            name=name,
            direction=PinDirection.INPUT,
            locs=locs,
            type=pin_type
        )
        assert pin.name not in switchbox.inputs, pin
        switchbox.inputs[pin.name] = pin

    return switchbox


# =============================================================================

def populate_switchboxes(xml_sbox, switchbox_grid):

    if xml_sbox.get("ColStartNum") is None:
        xml_matrices = [x for x in xml_sbox if x.tag.startswith("Matrix")]
        for curr_matrix in xml_matrices:
            """
            Assings each tile in the grid its switchbox type.
            """
            xmin = int(curr_matrix.attrib["ColStartNum"])
            xmax = int(curr_matrix.attrib["ColEndNum"])
            ymin = int(curr_matrix.attrib["RowStartNum"])
            ymax = int(curr_matrix.attrib["RowEndNum"])

            for y, x in itertools.product(range(ymin, ymax + 1), range(xmin,
                                                                    xmax + 1)):
                loc = Loc(x, y, 0)

                assert loc not in switchbox_grid, loc
                switchbox_grid[loc] = xml_sbox.tag
                #print("---SB_LC loc: ", loc, " .. sbox.tag: ", switchbox_grid[loc])
    else:
        """
        Assings each tile in the grid its switchbox type.
        """
        xmin = int(xml_sbox.attrib["ColStartNum"])
        xmax = int(xml_sbox.attrib["ColEndNum"])
        ymin = int(xml_sbox.attrib["RowStartNum"])
        ymax = int(xml_sbox.attrib["RowEndNum"])

        for y, x in itertools.product(range(ymin, ymax + 1), range(xmin,
                                                                xmax + 1)):
            loc = Loc(x, y, 0)

            assert loc not in switchbox_grid, loc
            switchbox_grid[loc] = xml_sbox.tag
            #print("---interface loc: ", loc, " .. sbox.tag: ", switchbox_grid[loc])


# =============================================================================
def parse_switchbox_ap3(xml_sbox, xml_common=None):
    """
    Parses the switchbox definition from XML. Returns a Switchbox object
    """
    switchbox = Switchbox(type=xml_sbox.tag)

    # Identify stages. Append stages from the "COMMON_STAGES" section if
    # given.
    stages = [n for n in xml_sbox if n.tag.startswith("STAGE")]

    if xml_common is not None:
        common_stages = [n for n in xml_common if n.tag.startswith("STAGE")]
        stages.extend(common_stages)

    # Load stages
    for xml_stage in stages:
        # Get stage id
        stage_id = int(xml_stage.attrib["StageNumber"])
        assert stage_id not in switchbox.stages, (
            stage_id, switchbox.stages.keys()
        )

        stage_type = xml_stage.attrib["StageType"]

        # Add the new stage
        stage = Switchbox.Stage(id=stage_id, type=stage_type)
        switchbox.stages[stage_id] = stage

        # Process outputs
        switches = {}
        for xml_output in xml_stage.findall("Output"):
            out_id = int(xml_output.attrib["Number"])
            out_switch_id = int(xml_output.attrib["SwitchNum"])
            out_pin_id = int(xml_output.attrib["SwitchOutputNum"])
            out_pin_name = xml_output.get("JointOutputName", None)

            # These indicate unconnected top-level output.
            if out_pin_name in ["-1"]:
                out_pin_name = None

            # Add a new switch if needed
            if out_switch_id not in switches:
                switches[out_switch_id] = Switchbox.Switch(
                    out_switch_id, stage_id
                )
            switch = switches[out_switch_id]

            # Add a mux for the output
            mux = Switchbox.Mux(out_pin_id, switch.id)
            assert mux.id not in switch.muxes, mux
            switch.muxes[mux.id] = mux

            # Add output pin to the mux
            mux.output = SwitchPin(
                id=0, name=out_pin_name, direction=PinDirection.OUTPUT
            )

            # Process inputs
            for xml_input in xml_output:
                inp_hop_dir = ""
                if xml_input.get("WireName", None) is not None:
                    inp_pin_id = int(xml_input.tag.replace("Input", ""))
                    inp_pin_name = xml_input.get("WireName", None)
                    inp_hop_dir = xml_input.get("Direction", None)
                    inp_hop_len = int(xml_input.get("Length", "-1"))
                elif xml_input.get("Stage", None) is not None:
                    #internal connections, so create a switchPin with None pin_name
                    inp_pin_id = int(xml_input.tag.replace("Input", ""))
                    inp_pin_name = "-1"

                # These indicate unconnected top-level input.
                if inp_pin_name in ["-1"]:
                    inp_pin_name = None

                # Append the actual wire length and hop direction to names of
                # pins that connect to HOP wires.
                is_hop = (inp_hop_dir in ["Left", "Right", "Top", "Bottom"])
                if is_hop:
                    inp_pin_name = "{}_{}{}".format(
                        inp_pin_name, inp_hop_dir[0], inp_hop_len
                    )

                # Add the input to the mux
                pin = SwitchPin(
                    id=inp_pin_id,
                    name=inp_pin_name,
                    direction=PinDirection.INPUT
                )

                assert pin.id not in mux.inputs, pin
                mux.inputs[pin.id] = pin

                # Add internal connection
                if stage_type == "STREET":
                    if xml_input.get("Stage", None) is not None:
                        if xml_input.get("Stage") is not None:
                            conn_stage_id = int(xml_input.attrib["Stage"])
                            conn_switch_id = int(xml_input.attrib["SwitchNum"])
                            conn_pin_id = int(xml_input.attrib["SwitchOutputNum"])

                            conn = SwitchConnection(
                                src=SwitchboxPinLoc(
                                    stage_id=conn_stage_id,
                                    switch_id=conn_switch_id,
                                    mux_id=conn_pin_id,
                                    pin_id=0,
                                    pin_direction=PinDirection.OUTPUT
                                ),
                                dst=SwitchboxPinLoc(
                                    stage_id=stage.id,
                                    switch_id=switch.id,
                                    mux_id=mux.id,
                                    pin_id=inp_pin_id,
                                    pin_direction=PinDirection.INPUT
                                ),
                            )

                            assert conn not in switchbox.connections, conn
                            switchbox.connections.add(conn)

        # Add switches to the stage
        stage.switches = switches

    # Update top-level pins
    update_switchbox_pins(switchbox)

    print("switchbox: ", switchbox)
    return switchbox

# =============================================================================
def import_routing(techfile):

    # Read and parse the XML archfile
    parser = ET.XMLParser(resolve_entities=False, strip_cdata=False)
    xml_tree = ET.parse(techfile, parser)
    xml_root = xml_tree.getroot()
    """
    Imports the Quicklogic FPGA routing data from the given XML tree
    """
    device_name = xml_root.get("name")

    if device_name == "ArcticPro3":
        # Get the "Routing" section
        xml_routing = xml_root.find("Routing")
        assert xml_routing is not None

        ## Import switchboxes
        switchbox_grid = {}
        switchbox_types = {}
        for xml_node in xml_routing:

            # Not a switchbox
            if not xml_node.tag.endswith("_SBOX"):
                continue

            # Load all "variants" of the switchbox
            xml_common = xml_node.find("COMMON_STAGES")
            for xml_sbox in xml_node:
                if xml_sbox != xml_common:

                    # Parse the switchbox definition
                    switchbox = parse_switchbox_ap3(xml_sbox, xml_common)
                    assert switchbox.type not in switchbox_types, switchbox.type
                    switchbox_types[switchbox.type] = switchbox

                    # Populate switchboxes onto the tilegrid
                    populate_switchboxes(xml_sbox, switchbox_grid)

