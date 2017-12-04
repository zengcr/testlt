#!/bin/bash 
 
# filename   : keystone-add-user.sh 
# created at : 2013-08-30 16:27:56 
# author     : Jianing Yang <a href="mailto:jianingy%40unitedstack.com">&lt;jianingy@unitedstack.com&gt;</a> 
 
until [ -z "$1" ]; do 
    case "$1" in 
        --tenant) 
            shift 
            opt_tenant=${1:-service} 
        ;; 
        --role) 
            shift 
            opt_role=${1:-admin} 
        ;; 
        --name) 
            shift 
            opt_name=$1 
        ;; 
    esac 
    shift 
done 
 
# find tenant id, create a new one if not exist 
tenant_id=$(keystone tenant-get "$opt_tenant" | awk "/id/{print $4}") 
if [ -z "$tenant_id" ]; then 
  keystone tenant-create --name "$opt_tenant" || exit 11 
  tenant_id=$(keystone tenant-get "$opt_tenant" | awk "/id/{print $4}") 
  [ -z "$tenant_id" ] &amp;&amp; exit 11 
fi 
 
# find role id, create a new one if not exist 
role_id=$(keystone role-get "$opt_role" | awk "/id/{print $4}") 
if [ -z "$role_id" ]; then 
  keystone role-create --name "$opt_role" || exit 22 
  role_id=$(keystone role-get "$opt_role" | awk "/id/{print $4}") 
  [ -z "$role_id" ] &amp;&amp; exit 22 
fi 
 
# find user id, create a new user if not exist 
user_id=$(keystone user-get "$opt_name" | awk "/id/{print $4}") 
if [ -z "$user_id" ]; then 
  keystone user-create --name "$opt_name" --pass "$opt_name" --email "$opt_name@localhost" --tenant_id "$tenant_id" || exit 33 
  user_id=$(keystone user-get "$opt_name" | awk "/id/{print $4}") 
  [ -z "$user_id" ] &amp;&amp; exit 33 
fi 
 
# attach role to user 
keystone user-role-add --user_id "$user_id" --role_id "$role_id" --tenant_id "$tenant_id" | exit 44 