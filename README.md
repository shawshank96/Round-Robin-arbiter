- This is 4-request round robin arbiter. 
- It is an active HIGH reset and active HIGH enable.
- If Reset is active then no requestor gets a grant and the counter is reset too. 
- If enable is active then no requestor gets a grant but the counter state is preserved.  
- During clocks   0 - 100, the order of priority is as: 0>1>2>3
- During clocks 100 - 200, the order of priority is as: 1>2>3>0
- During clocks 200 - 300, the order of priority is as: 2>3>0>1
- During clocks 300 - 400, the order of priority is as: 3>0>1>2
