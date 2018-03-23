import os
import time


for filename in os.listdir('/Users/bloom/byte/vps'):
	try:
		os.remove('/Users/bloom/byte/vps/myfile.sh') 
		os.remove('/Users/bloom/byte/vps/start.sh')
		os.remove('/Users/bloom/byte/vps/vps_start.sh')
		os.remove('/Users/bloom/byte/vps/local.sh') 
		os.remove('/Users/bloom/byte/vps/remote.sh')
		os.remove('/Users/bloom/byte/vps/end.sh')
		os.remove('/Users/bloom/byte/vps/login.sh')
		os.remove('/Users/bloom/byte/vps/.nanorc')
		os.remove('/Users/bloom/byte/vps/.credentials')
	except OSError:
    		pass