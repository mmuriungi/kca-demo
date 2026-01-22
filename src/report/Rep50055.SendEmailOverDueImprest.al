report 50055 "Send Email(OverDue Imprest)"
{
    ApplicationArea = All;
    Caption = 'Send Email(OverDue Imprest)';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    dataset
    {
        dataitem(HrmEmployee; "Hrm-Employee C")
        {
            trigger OnAfterGetRecord()
            begin
                ImprestHeader.SetRange("Account No.", HrmEmployee."No.");
                ImprestHeader.SetFilter(Posted, '=%1', true);
                ImprestHeader.SetFilter("Posted To Payroll", '=%1', false);
                ImprestHeader.SetFilter("Expected Date of Surrender", '<=%1', Today);
                if ImprestHeader.Find('-') then begin
                    ImprestHeader.CalcFields("Total Net Amount");
                    //EmailBody:=
                    if MailMgt.CheckValidEmailAddress(HrmEmployee."E-Mail") then begin
                        EmailMsg.Create(HrmEmployee."E-Mail", MailSubj, EmailBody, true);
                        Email.Send(EmailMsg)
                    end;
                end;
            end;
        }

    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    var
        ImprestHeader: Record "FIN-Imprest Header";
        EmailMsg: Codeunit "Email Message";
        Email: Codeunit Email;
        MailSubj: Label 'Imprest Recovery From Payroll';
        EmailBody: labEL 'Dear %1 Please Note That Your Emprest Request %2 of %3 Is Due On %4';
        MailMgt: Codeunit "Mail Management";

}
