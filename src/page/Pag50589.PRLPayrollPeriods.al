page 50589 "PRL-Payroll Periods"
{
    PageType = List;
    Editable = true;
    //DeleteAllowed = false;
    SourceTable = "PRL-Payroll Periods";
    SourceTableView = WHERE("Payroll Code" = FILTER(<> 'CASUAL' | 'CASUALS'));
    UsageCategory = None;


    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field("Period Month"; Rec."Period Month")
                {
                    //Editable = false;
                    ApplicationArea = all;

                }
                field("Period Year"; Rec."Period Year")
                {
                    ApplicationArea = all;
                    //Editable = false;
                }
                field("Period Name"; Rec."Period Name")
                {
                    ApplicationArea = all;
                    //Editable = false;
                }
                field("Date Opened"; Rec."Date Opened")
                {
                    ApplicationArea = all;
                    //Editable = false;
                }
                field("Date Closed"; Rec."Date Closed")
                {
                    ApplicationArea = all;
                    //Editable = false;
                }
                field(Closed; Rec.Closed)
                {
                    ApplicationArea = all;
                    //Editable = false;
                }
                field("Payroll Code"; Rec."Payroll Code")
                {
                    ApplicationArea = all;
                    //Editable = true;
                }
                field("Allow View of Online Payslips"; Rec."Allow View of Online Payslips")
                {
                    ApplicationArea = all;
                    Caption = 'View Online';
                }
                field("PayPeriod.""Approval Comments"""; PayPeriod."Approval Comments")
                {
                    ApplicationArea = all;
                    Caption = 'Approval Comments';
                }
                field("PayPeriod.""Approved For Closure"""; PayPeriod."Approved For Closure")
                {
                    ApplicationArea = all;
                    Caption = 'Approved';
                    //Editable = true;
                }
                field("PayPeriod.""Approved By"""; PayPeriod."Approved By")
                {
                    ApplicationArea = all;
                    Caption = 'Approved by';
                    //Editable = true;
                }
                field("PayPeriod.""Approved Date"""; PayPeriod."Approved Date")
                {
                    ApplicationArea = all;
                    Caption = 'Approved date';
                    //Editable = true;
                }
                field("PayPeriod.""Approved Time"""; PayPeriod."Approved Time")
                {
                    ApplicationArea = all;
                    Caption = 'Approved Time';
                    //Editable = true;
                }
                field("Payslip Message"; Rec."Payslip Message")
                {
                    ApplicationArea = all;
                    Caption = 'Payslip message';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(ApproveClosure)
            {
                ApplicationArea = all;
                Caption = 'Approve Closure';
                Image = Approve;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    usersteup: Record "User Setup";
                begin
                    if not Rec.ApprovePayroll then Error('You do NOT have permission to Approve Closure OF Payroll');
                    PayPeriod.Reset;
                    PayPeriod.SetRange(Closed, false);
                    if PayPeriod.Find('-') then begin
                        if PayPeriod."Approval Comments" = '' then Error('Please Provide Approval Comments');
                        PayPeriod."Approved By" := UserId;
                        PayPeriod."Approved Date" := Today;
                        PayPeriod."Approved For Closure" := true;
                        PayPeriod."Approved Time" := Time;
                        PayPeriod.Closed := true;
                        PayPeriod.Modify;
                    end;
                end;
            }
            action("Close Period")
            {
                ApplicationArea = all;
                Caption = 'Close Period';
                Image = ClosePeriod;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    /*
                    Warn user about the consequence of closure - operation is not reversible.
                    Ask if he is sure about the closure.
                    */

                    fnGetOpenPeriod;

                    Question := 'Once a period has been closed it can NOT be opened.'
                    + 'Do you still want to close [' + strPeriodName + ']';

                    //For Multiple Payroll
                    ContrInfo.Get();
                    if ContrInfo."Multiple Payroll" then begin
                        PayrollDefined := '';
                        PayrollType.SetCurrentKey(EntryNo);
                        if PayrollType.FindFirst then begin
                            NoofRecords := PayrollType.Count;
                            repeat
                                i += 1;
                                PayrollDefined := PayrollDefined + '&' + PayrollType."Payroll Code";
                                if i < NoofRecords then
                                    PayrollDefined := PayrollDefined + ','
                            until PayrollType.Next = 0;
                        end;


                        Selection := StrMenu(PayrollDefined, 3);
                        PayrollType.Reset;
                        PayrollType.SetRange(PayrollType.EntryNo, Selection);
                        if PayrollType.Find('-') then begin
                            PayrollCode := PayrollType."Payroll Code";
                            PayPeriod.Closed := true;
                        end;
                    end;
                    //End Multiple Payroll



                    Answer := DIALOG.Confirm(Question, false);
                    if Answer = true then begin
                        Clear(objOcx);
                        objOcx.fnClosePayrollPeriod(dtOpenPeriod, PayrollCode);
                        PayPeriod.Closed := true;
                        Message('Process Complete');
                    end else begin
                        Message('You have selected NOT to Close the period');
                    end

                end;
            }
            action(updateP9)
            {
                ApplicationArea = all;
                Caption = 'Update P9 Date';
                Image = UpdateUnitCost;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    prEmployeeP9Info: Record "PRL-Employee P9 Info";
                begin
                    if not (Rec.Closed) then Error('The period is still open!');
                    if not (Confirm('Update P9 information for ' + Rec."Period Name" + '?')) then Error('Cancelled by user!');
                    Clear(objOcx);
                    prEmployeeP9Info.Reset();
                    prEmployeeP9Info.SetRange("Period Month", Rec."Period Month");
                    prEmployeeP9Info.SetRange("Period Year", Rec."Period Year");
                    prEmployeeP9Info.SetRange("Payroll Period", Rec."Date Opened");
                    //prEmployeeP9Info.SetRange("Payroll Code", Rec."Payroll Code");
                    prEmployeeP9Info.DeleteAll();
                    objOcx.fnP9PeriodClosure(Rec."Period Month", Rec."Period Year", Rec."Date Opened", Rec."Payroll Code");
                    Message('P9 information for ' + Rec."Period Name" + ' Successfully updated.');
                end;
            }
        }
    }

    var
        PayPeriod: Record "PRL-Payroll Periods";
        strPeriodName: Text[100];
        Text000: Label '''Leave without saving changes?''';
        Text001: Label '''You selected %1.''';
        Question: Text[250];
        Answer: Boolean;
        objOcx: Codeunit prPayrollProcessing;
        dtOpenPeriod: Date;
        PayrollType: Record "PRL-Payroll Type";
        Selection: Integer;
        PayrollDefined: Text[100];
        PayrollCode: Code[20];
        NoofRecords: Integer;
        i: Integer;
        ContrInfo: Record "HRM-Control-Information";

    procedure fnGetOpenPeriod()
    begin

        //Get the open/current period
        PayPeriod.SetRange(PayPeriod.Closed, false);
        if PayPeriod.Find('-') then begin
            Rec.Validate(Closed);
            strPeriodName := PayPeriod."Period Name";
            dtOpenPeriod := PayPeriod."Date Opened";
        end;
    end;
}

