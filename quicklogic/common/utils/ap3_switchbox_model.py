from data_structs import *
from utils import yield_muxes
from rr_utils import add_node, connect

# =============================================================================


class Ap3SwitchboxModel(object):
    """
    Represents a model of connectivity of a concrete instance of a switchbox
    of AP3 architecture.

    In this switchbox model top-level inputs and internal mux outputs are
    modeled as individual rr nodes. Top-level outputs do not have separate
    nodes, there are nodes for mux outputs driving them already.

    Muxes are modeled as sets of rr edges. Each edge spans across either an
    input pin node and a mux output or between two consecutive mux output
    nodes.

    Edges are assigned fasm_features as metadata.
    """

    def __init__(self, graph, loc, phy_loc, switchbox):
        self.graph = graph
        self.loc = loc
        self.phy_loc = phy_loc
        self.switchbox = switchbox

        self.input_to_node = {}
        self.mux_output_to_node = {}

    @staticmethod
    def get_metadata_for_mux(loc, stage, switch_id, mux_id, pin_id):
        """
        Formats fasm features for the given edge representin a switchbox mux.
        Returns a list of fasm features.
        """
        metadata = []

        # TODO: Once fasm feature names are established add them here

        return metadata

    @staticmethod
    def get_chan_dirs_for_stage(stage):
        """
        Returns channel directions for inputs and outputs of a stage.
        """

        if stage.type == "HIGHWAY":
            return "Y", "X"

        elif stage.type == "STREET":
            dir_inp = "Y" if (stage.id % 2) else "X"
            dir_out = "X" if (stage.id % 2) else "Y"
            return dir_inp, dir_out

        else:
            assert False, stage.type

    def _create_nodes(self):
        """
        Adds nodes that represent input pins and mux outputs.
        """

        segment_id = self.graph.get_segment_id_from_name("sbox")


        # Create input nodes for each top-level input pin
        for pin in self.switchbox.inputs.values():

            node = add_node(self.graph, self.loc, "Y", segment_id)

            assert pin.name not in self.input_to_node, pin.name
            self.input_to_node[pin.name] = node

        # Create output nodes for mux outputs
        for stage, switch, mux in yield_muxes(self.switchbox):
            dir_inp, dir_out = self.get_chan_dirs_for_stage(stage)

            # Add a node for mux output
            key = (stage.id, switch.id, mux.id)
            assert key not in self.mux_output_to_node

            node = add_node(self.graph, self.loc, dir_out, segment_id)
            self.mux_output_to_node[key] = node


    def _create_edges(self):
        """
        Adds edges that connect input pin nodes with muxes and edges between
        internal muxes of the switchbox.
        """

        segment_id = self.graph.get_segment_id_from_name("sbox")

        # Create edges for input node to mux connections
        for pin in self.switchbox.inputs.values():

            # Source (input) node
            src_node = self.input_to_node[pin.name]

            # Add edges for muxes that connect to this pin
            for loc in pin.locs:
                key = (loc.stage_id, loc.switch_id, loc.mux_id)
                dst_node = self.mux_output_to_node[key]

                # Get edge metadata
                metadata = self.get_metadata_for_mux(
                    self.phy_loc,
                    self.switchbox.stages[loc.stage_id],
                    loc.switch_id,
                    loc.mux_id,
                    loc.pin_id
                )

                if len(metadata):
                    meta_name = "fasm_features"
                    meta_value = "\n".join(metadata)
                else:
                    meta_name = None
                    meta_value = ""

                # Get edge switch
                # FIXME: Use appropriate switch here
                vpr_switch_id = self.graph.get_delayless_switch_id()

                # Add the edge
                connect(
                    self.graph,
                    src_node,
                    dst_node,
                    switch_id=vpr_switch_id,
                    segment_id=segment_id,
                    meta_name=meta_name,
                    meta_value=meta_value,
                )

        # Create mux edges for internal connections
        for connection in self.switchbox.connections:

            # Source node
            ept = connection.src
            key = (ept.stage_id, ept.switch_id, ept.mux_id)
            src_node = self.mux_output_to_node[key]
            
            # Destination node
            ept = connection.dst
            key = (ept.stage_id, ept.switch_id, ept.mux_id)
            dst_node = self.mux_output_to_node[key]

            # Get edge metadata
            ept = connection.dst
            metadata = self.get_metadata_for_mux(
                self.phy_loc,
                self.switchbox.stages[ept.stage_id],
                ept.switch_id,
                ept.mux_id,
                ept.pin_id
            )

            if len(metadata):
                meta_name = "fasm_features"
                meta_value = "\n".join(metadata)
            else:
                meta_name = None
                meta_value = ""

            # Get edge switch
            # FIXME: Use appropriate switch here
            vpr_switch_id = self.graph.get_delayless_switch_id()

            # Add the edge
            connect(
                self.graph,
                src_node,
                dst_node,
                switch_id=vpr_switch_id,
                segment_id=segment_id,
                meta_name=meta_name,
                meta_value=meta_value,
            )

    def build(self):
        """
        Build the switchbox model by creating and adding its nodes and edges
        to the RR graph.
        """

        self._create_nodes()
        self._create_edges()

    def get_input_node(self, pin_name):
        """
        Returns a VPR node associated with the given input of the switchbox
        """
        return self.input_to_node[pin_name]

    def get_output_node(self, pin_name):
        """
        Returns a VPR node associated with the given output of the switchbox
        """

        # Get the output pin
        pin = self.switchbox.outputs[pin_name]

        assert len(pin.locs) == 1
        loc = pin.locs[0]

        # Return its node
        key = (loc.stage_id, loc.switch_id, loc.mux_id)
        return self.mux_output_to_node[key]


