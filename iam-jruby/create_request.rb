require 'java'
require 'xlclient'
 
include_class('java.lang.Exception') {|package,name| "J#{name}" }
include_class 'java.lang.System'
include_class 'java.util.HashMap'
include_class 'java.util.HashSet'
include_class 'java.util.ArrayList'

include_class 'oracle.iam.request.vo.RequestData'
include_class 'oracle.iam.request.vo.RequestTemplate'
include_class 'oracle.iam.request.vo.RequestEntity'
include_class 'oracle.iam.request.vo.RequestEntityAttribute'

login = 'TEST'

usrHash = {
    'User Login' => login ,
    'First Name' => login + 'First' ,
    'Middle Name' => login + 'Middle' ,
    'Last Name' => login + 'Last' ,
    'Password' => 'foo',
    'Role' => 'Full-Time',
    'User Type' => 'End-User',
    'Organization' => 1,
    'User Manager' => 6
}

xlclient = XLAPIClient.new
xlclient.defaultLogin

t1 = System.currentTimeMillis

reqSvc = xlclient.getUtility('reqsvc')

# Build the reqData object
reqData = RequestData.new('Create User')
reqData.setJustification('random tryouts')

ent = RequestEntity.new
ent.setEntityType('User')

attrs = ArrayList.new

usrHash.each {|key, val| 
    if key == 'Organization' or key == 'User Manager'
        attr = RequestEntityAttribute.new(key, val.to_s, RequestEntityAttribute::TYPE::Long)
    else
        attr = RequestEntityAttribute.new(key, val, RequestEntityAttribute::TYPE::String)
    end

    attrs.add(attr)
}

ent.setEntityData(attrs)

entities = ArrayList.new
entities.add(ent)

reqData.setTargetEntities(entities)

# validate it
reqSvc.validateRequestData(reqData)

# submit
reqID = reqSvc.submitRequest(reqData)

t2 = System.currentTimeMillis
 
delta = t2-t1

puts "Created Request for creating user with login #{login}. Request ID = #{reqID}. Time = #{delta}"

xlclient.logout
System.exit 0

