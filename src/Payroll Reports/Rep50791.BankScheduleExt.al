report 50791 "Bank Schedule Ext"
{
    DefaultLayout = RDLC;
    Caption = 'Bank Schedule';
    RDLCLayout = './PayrollLayouts/Bank schedule.rdlc';

    dataset
    {
        dataitem(Ptrans; "PRL-Period Transactions")
        {
            DataItemTableView = where("Transaction Code"=const('NPAY'));
            column(ReportForNavId_1000000000; 1000000000)
            {
            }
            column(EmployeeCode_Ptrans;Ptrans."Employee Code")
            {
            }
            column(TransactionCode_Ptrans;Ptrans."Transaction Code")
            {
            }
            column(GroupText_Ptrans;Ptrans."Group Text")
            {
            }
            column(TransactionName_Ptrans;Ptrans."Transaction Name")
            {
            }
            column(Amount_Ptrans;Ptrans.Amount)
            {
            }
            column(empname;empName)
            {
            }
            column(period;Format(period))
            {
            }
            column(accno;accno)
            {
            }
            column(branch;branch)
            {
            }
            column(branchCode;branchCode)
            {
            }
            column(bnkname;bnkname)
            {
            }
            column(bankcode;bankcode)
            {
            }

            trigger OnAfterGetRecord()
            begin
                scard.Reset;
                scard.SetRange("No.", Ptrans."Employee Code");
                if scard.Find('-') then begin
                 empName := scard."First Name"+ ' '+ scard."Middle Name"+ ' '+scard."Last Name";
                  accno:= scard."Bank Account Number";
                  branch:= scard."Branch Bank";

                  branchCode:= scard."Branch Bank";
                  bankcode:= scard."Main Bank";

                  bnks.Reset;
                  bnks.SetRange("Bank Code", bankcode);
                  bnks.SetRange("Branch Code", branchCode);
                  if bnks.Find('-') then begin
                       bnkname:= bnks."Branch Name";
                   end;


                 end;
            end;

            trigger OnPreDataItem()
            begin
                Ptrans.SetFilter("Payroll Period",'%1', period);
                Ptrans.SetFilter("Transaction Code",'%1', 'NPAY');
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Control1000000000)
                {
                    field(period;period)
                    {
                        ApplicationArea = Basic;
                        TableRelation = "PRL-Payroll Periods"."Date Opened";
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        period: Date;
        scard: Record "HRM-Employee C";
        empName: Text;
        Trans2: Record "PRL-Period Transactions";
        branch: Code[20];
        accno: Code[20];
        bnks: Record "PRL-Bank Structure";
        bnkname: Text;
        branchCode: Code[20];
        bankcode: Code[10];
}

