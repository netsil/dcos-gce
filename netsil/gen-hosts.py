#!/usr/bin/env python
from jinja2 import Environment, FileSystemLoader
import argparse

# Dumb way to get next n ip addresses from starting ip start_ip
def dumb_get_next_ips(starting_ip, n):
    ip_tokens = starting_ip.split('.')
    last = int(ip_tokens[3])
    ip_range = list()
    for i in range(n):
        next_ip = ip_tokens[0:2].append(last + 1)
        ip_range.append(ip_tokens[0:2])
    return ip_range

def main(args):
    # Generate master/agent strings
    num_masters = int(args.masters)
    num_agents = int(args.agents)
    masterList = list()
    next_ips = dumb_get_next_ips(args.starting_ip, n)
    for i in range(num_masters):
        masterList.append("netsil-cloud-master" + str(i) + " ip=" + str(next_ips[i]))

    for i in range(num_agents):
        agentList.append("netsil-cloud-agent" + '%04d' % i)

    # Templating
    env = Environment(loader=FileSystemLoader('.'))
    template = env.get_template('hosts.tmpl')
    output_from_parsed_template = template.render(masterList=masterList, agentList=agentList)
    print output_from_parsed_template

    # to save the results
    with open("hosts", "wb") as fh:
        fh.write(output_from_parsed_template)

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='For generating delta sequences between two sets of marathon JSON specs')
    parser.add_argument('-m', '--masters', default='3', dest='masters', type=str, nargs='?')
    parser.add_argument('-a', '--agents', default='4', dest='agents', type=str, nargs='?')
    parser.add_argument('-s', '--starting-ip', default='10.138.1.0', dest='starting_ip', type=str, nargs='?')
    args = parser.parse_args()
    main(args)
