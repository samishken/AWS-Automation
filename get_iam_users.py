import subprocess as sp
import csv
import json
cmd="aws iam list-users"

out_err=sp.Popen(cmd, shell=True, stdout=sp.PIPE, stderr=sp.PIPE)
rt=out_err.wait()
out,err=out_err.communicate()

#print(out)

out_dict=json.loads(out)

#print(out_dict)

fo=open("iam_user.csv",'w')
wo=csv.writer(fo)
wo.writerow(['IAMS USER','CreationDate'])

#creating dictionary for each uers
for each_user in out_dict['Users']:
    wo.writerow([each_user['UserName'], each_user['CreateDate']])
print("-------------------------")
print(err)


