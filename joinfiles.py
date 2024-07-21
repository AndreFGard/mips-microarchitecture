import os

forbiddenlist = ["testbench", "masterfile","appendedfile", 'ttb', "LIC", "py", "txt", ".md", ".vpp"]
filelist = os.listdir()

destination = "dest.sv"
dest = open("appendedfile.sv", "w")


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