#!/usr/bin/env python3
import os
import argparse
import pickle
from collections import namedtuple
from collections import OrderedDict

import lxml.etree as ET
import xml.dom.minidom

# =============================================================================
def replace(parent_node, base_path):

    xi_url = "http://www.w3.org/2001/XInclude"
    ET.register_namespace("xi", xi_url)
    nsmap = {"xi": xi_url}

    xml_node = parent_node.find("xi:include", nsmap)

    if xml_node is not None:
        href_path = xml_node.get("href")
        curr_file = os.path.join(base_path, href_path)
        if os.path.isfile(curr_file) != True:
            print("File: '", curr_file, "' does not exist.")
        else:
            # Read and parse the XML archfile
            parser = ET.XMLParser(resolve_entities=False, strip_cdata=False)
            xml_tree = ET.parse(curr_file, parser)
            xml_inc_root = xml_tree.getroot()

            base_path = os.path.dirname(curr_file)

            child_index = 0
            for child_node in xml_inc_root:
                if child_node.tag == "blif_model":
                    parent_node.set(child_node.tag, child_node.text)
                else:
                    parent_node.insert(child_index, child_node)
                child_index += 1
                replace(child_node, base_path)

            parent_node.remove(xml_node)
    else:
        for child_node in parent_node:
            replace(child_node, base_path)

# =============================================================================
def main():

    # Parse arguments
    parser = argparse.ArgumentParser(
        description=__doc__,
        formatter_class=argparse.RawDescriptionHelpFormatter
    )

    parser.add_argument(
        "--arch-in", type=str, required=True, help="Input arch XML file"
    )
    parser.add_argument(
        "--arch-out",
        type=str,
        default="arch.xml",
        help="Output arch XML file (def. arch.xml)"
    )

    args = parser.parse_args()

    # Read and parse the XML archfile
    parser = ET.XMLParser(resolve_entities=False, strip_cdata=False)
    xml_tree = ET.parse(args.arch_in, parser)
    xml_archfile = xml_tree.getroot()

    base_path = os.path.dirname(args.arch_in)

    for child_node in xml_archfile:
        replace(child_node, base_path)

    # Save the arch
    curr_xml = xml.dom.minidom.parseString(
        ET.tostring(xml_archfile, pretty_print=True, encoding='utf-8')
    )

    contents = ""
    for line in curr_xml.toprettyxml().split('\n'):
        if not line.strip() == '':
            contents += line + "\n"

    with open(args.arch_out, 'w') as fp:
        fp.write(contents)

    # Commenting as indentation is not appropriate
    #ET.ElementTree(xml_archfile).write(
    #    args.arch_out,
    #    pretty_print=True,
    #    encoding="utf-8"
    #)

# =============================================================================

if __name__ == "__main__":
    main()
