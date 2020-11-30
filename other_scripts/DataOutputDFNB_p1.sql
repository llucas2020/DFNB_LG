CREATE VIEW  dbo.v_Open_Close_Code AS
SELECT count(branch_id) as 'Accounts'
, branch_id
, open_close_code
from dbo.tlb_Account_Dim
Group By open_close_code, branch_id
Order by branch_id;

select * from dbo.tlb_Account_Dim

