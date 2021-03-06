#!/usr/bin/env python
from jinja2 import Environment, FileSystemLoader
import yaml
import argparse
import os

BASE_KEY = os.environ.get('BASE_KEY')

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

def gen_hosts(args, outfile="hosts"):
    # Generate master/agent strings
    num_masters, num_agents = int(args.masters), int(args.agents)
    masterList, agentList = list(), list()
    next_ips = dumb_get_next_ips(args.starting_ip, num_masters)
    for i in range(num_masters):
        masterList.append(BASE_KEY + "-master" + str(i) + " ip=" + str(next_ips[i]))

    for i in range(num_agents):
        agentList.append(BASE_KEY + "-agent" + str('%04d' % (i + 1)))

    # Templating
    env = Environment(loader=FileSystemLoader('./'))
    template = env.get_template('hosts.tmpl')
    output_from_parsed_template = template.render(masterList=masterList, agentList=agentList)
    print output_from_parsed_template

    # to save the results
    with open(outfile, "wb") as fh:
        fh.write(output_from_parsed_template)

def gen_new_worker_host(args, outfile="additional-hosts"):
    # Generate master/agent strings
    num_masters, num_agents = int(args.masters), int(args.agents)
    masterList, agentList = list(), list()
    next_ips = dumb_get_next_ips(args.starting_ip, num_masters)
    for i in range(num_masters):
        masterList.append(BASE_KEY + "-master" + str(i) + " ip=" + str(next_ips[i]))

    agentList.append(BASE_KEY + "-agent" + args.new_worker)

    # Templating
    env = Environment(loader=FileSystemLoader('./'))
    template = env.get_template('hosts.tmpl')
    output_from_parsed_template = template.render(masterList=masterList, agentList=agentList)
    print output_from_parsed_template

    # to save the results
    with open(outfile, "wb") as fh:
        fh.write(output_from_parsed_template)

def gen_start_end_ids(args):
    num_agents = int(args.agents)
    print "start_id=0001 end_id=" + '%04d' % num_agents

def get_num_masters():
    with open("group_vars/all", 'r') as stream:
        try:
            cloud_vars = yaml.load(stream, Loader=yaml.BaseLoader)
            return int(cloud_vars['masters'])
        except yaml.YAMLError as exc:
            print(exc)

def get_num_agents():
    with open("group_vars/all", 'r') as stream:
        try:
            cloud_vars = yaml.load(stream, Loader=yaml.BaseLoader)
            end_id = cloud_vars['end_id']
            return int(end_id.lstrip("0"))
        except yaml.YAMLError as exc:
            print(exc)

def get_starting_ip():
    with open("group_vars/all", 'r') as stream:
        try:
            cloud_vars = yaml.load(stream, Loader=yaml.BaseLoader)
            return cloud_vars['starting_ip']
        except yaml.YAMLError as exc:
            print(exc)

def get_new_worker(args):
    with open(args.current_hosts_file, 'r') as chf:
        agent_ids = list()
        for line in chf:
            line = line.strip()
            agent_ids.append(line[-4:])
        agent_ids.sort()
        last = int(agent_ids[-1])
        new = last + 1
        print '%04d' % new

def main(args):
    args.masters, args.agents = get_num_masters(), get_num_agents()
    args.starting_ip = get_starting_ip()
    action = args.action
    if action == 'gen_hosts':
        gen_hosts(args)
    elif action == 'gen_start_end_ids':
        gen_start_end_ids(args)
    elif action == 'get_new_worker':
        get_new_worker(args)
    elif action == 'gen_new_worker_host':
        gen_new_worker_host(args)
    else:
        print "Invalid action!"

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='')
    parser.add_argument('-a', '--action', default='gen_hosts', dest='action', type=str, nargs='?')
    parser.add_argument('-c', '--current-hosts-file', default='current-hosts.tmp', dest='current_hosts_file', type=str, nargs='?')
    parser.add_argument('-n', '--new-worker', default='', dest='new_worker', type=str, nargs='?')
    parser.add_argument('-s', '--starting-ip', default='10.138.1.0', dest='starting_ip', type=str, nargs='?')
    args = parser.parse_args()
    main(args)

