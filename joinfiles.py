import os

forbiddenlist = ["testbench", 'ttb', "LIC"]
filelist = os.listdir()

destination = "dest.sv"
dest = open("destination.sv", "w")


for fname in filelist:
    valid = True
    if os.path.isdir(fname):
        valid = False

    for fb in forbiddenlist:
        if fb in fname:
            valid = False
    if valid:
        with open(fname, 'r') as f:
            dest.writelines(f.readlines())
