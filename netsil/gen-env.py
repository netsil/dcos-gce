#!/usr/bin/env python
import yaml
import argparse

# TODO: A lot of the code here is repeated in gen-hosts.py. Should refactor later.
def gen_env(args):
    with open("group_vars/all", 'r') as stream:
        try:
            cloud_vars = yaml.load(stream, Loader=yaml.BaseLoader)

            base_key = cloud_vars['base_key']
            if args.env != "masters" and args.env != "agents":
                print cloud_vars[args.env]
            elif args.env == "masters":
                num_masters = int(cloud_vars['masters'])
                masterList = list()
                for i in range(num_masters):
                    masterList.append(base_key + '-master' + str(i + 1))
                print ','.join(masterList)
            elif args.env == "agents":
                end_id = cloud_vars['end_id']
                num_agents = int(end_id.rstrip("0"))
                agentList = list()
                for i in range(num_agents):
                    num = '%04d' % (i + 1)
                    agentList.append(base_key + '-agent' + str(num))
                print ','.join(agentList)
            else:
                print "Should not have gotten here..."

        except yaml.YAMLError as exc:
            print(exc)

def main(args):
    action = args.action
    if action == 'gen_env':
        gen_env(args)
    else:
        print "Invalid action!"

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='')
    parser.add_argument('-a', '--action', default='gen_env', dest='action', type=str, nargs='?')
    parser.add_argument('-e', '--env', default='foo', dest='env', type=str, nargs='?')
    args = parser.parse_args()
    main(args)

