# How to Build and Install or Update

1. `cd` to the project root
2. **Build:** 

    `docker build . -f ./cloudron/Dockerfile -t tokilabs/outline-cloudron:[VERSION_NUMBER]-cloudron`

3. **Install:**
    
      `cloudron install --image tokilabs/outline-cloudron:[VERSION_NUMBER]-cloudron`
    
    **Update:**

      `cloudron update --image tokilabs/outline-cloudron:[VERSION_NUMBER]-cloudron`