#!/usr/bin/env python
from jinja2 import Environment, FileSystemLoader
import yaml
import argparse

# Dumb way to get next n ip addresses from starting ip start_ip
def dumb_get_next_ips(starting_ip, n):
    ip_tokens = starting_ip.split('.')
    last = int(ip_tokens[3])
    next_ips = list()
    for i in range(n):
        ip_toks_base = ip_tokens[:3]
        ip_toks_base.append(str(last + i))
        next_ips.append('.'.join(ip_toks_base))
    return next_ips

def gen_hosts(args):
    # Generate master/agent strings
    num_masters = int(args.masters)
    num_agents = int(args.agents)
    masterList, agentList = list(), list()
    next_ips = dumb_get_next_ips(args.starting_ip, num_masters)
    for i in range(num_masters):
        masterList.append("netsil-cloud-master" + str(i) + " ip=" + str(next_ips[i]))

    for i in range(num_agents):
        agentList.append("netsil-cloud-agent" + '%04d' % i)

    # Templating
    env = Environment(loader=FileSystemLoader('./'))
    template = env.get_template('hosts.tmpl')
    output_from_parsed_template = template.render(masterList=masterList, agentList=agentList)
    print output_from_parsed_template

    # to save the results
    #with open("hosts", "wb") as fh:
    #    fh.write(output_from_parsed_template)

def gen_start_end_ids(args):
    num_agents = int(args.agents)
    print "start_id=0001 end_id=" + '%04d' % num_agents

def get_num_agents():
    with open("group_vars/all", 'r') as stream:
        try:
            cloud_vars = yaml.load(stream, Loader=yaml.BaseLoader)
            end_id = cloud_vars['end_id']
            return int(end_id.rstrip("0"))
        except yaml.YAMLError as exc:
            print(exc)

def get_starting_ip():
    with open("group_vars/all", 'r') as stream:
        try:
            cloud_vars = yaml.load(stream, Loader=yaml.BaseLoader)
            return cloud_vars['starting_ip']
        except yaml.YAMLError as exc:
            print(exc)

def main(args):
    args.agents = get_num_agents()
    args.starting_ip = get_starting_ip()
    action = args.action
    if action == 'gen_hosts':
        gen_hosts(args)
    elif action == 'gen_start_end_ids':
        gen_start_end_ids(args)
    else:
        print "Invalid action!"

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='For generating delta sequences between two sets of marathon JSON specs')
    parser.add_argument('-a', '--action', default='gen_hosts', dest='action', type=str, nargs='?')
    parser.add_argument('-m', '--masters', default='3', dest='masters', type=str, nargs='?')
    parser.add_argument('-w', '--agents', default='2', dest='agents', type=str, nargs='?')
    parser.add_argument('-s', '--starting-ip', default='10.138.1.0', dest='starting_ip', type=str, nargs='?')
    args = parser.parse_args()
    main(args)

