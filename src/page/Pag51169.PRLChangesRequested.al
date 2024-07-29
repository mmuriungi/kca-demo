page 51169 "PRL-Changes Requested"
{
    PageType = List;
    SourceTable = "PRL-Payroll Variations";
    SourceTableView = WHERE(Closed = CONST(false));

    layout
    {
        area(content)
        {
            repeater(Control1102756000)
            {
                ShowCaption = false;
                field("Employee Code"; Rec."Employee Code")
                {
                }
                field("Payroll Period"; Rec."Payroll Period")
                {
                }
                field(Type; Rec.Type)
                {
                }
                field("Basic Pay"; Rec."Basic Pay")
                {
                }
                field("Effective Date"; Rec."Effective Date")
                {
                }
                field("Department Code"; Rec."Department Code")
                {
                }
                field("Transaction Code"; Rec."Transaction Code")
                {
                }
                field("New Amount"; Rec."New Amount")
                {
                }
                field("Hrs Worked"; Rec."Hrs Worked")
                {
                }
                field("Overtime Type"; Rec."Overtime Type")
                {
                }
                field("Created By"; Rec."Created By")
                {
                }
                field("Date Created"; Rec."Date Created")
                {
                }
                field("Approved By"; Rec."Approved By")
                {
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Function")
            {
                Caption = 'Function';
                action(Approve)
                {
                    Caption = 'Approve';
                    Image = Approve;

                    trigger OnAction()
                    begin
                        Rec.SetRange(Status, Rec.Status::Approved);
                        Rec.SetRange(Closed, false);
                        if Rec.Find('-') then begin
                            repeat
                                Rec.Closed := true;
                                Rec."Date Closed" := Today;
                                Rec."Approved By" := UserId;
                                Rec.Modify;
                            until Rec.Next = 0;
                        end;
                    end;
                }
                separator(Separator1102756031)
                {
                }
                action(Print)
                {
                    Caption = 'Print';
                    Image = Print;

                    trigger OnAction()
                    begin
                        Rec.Reset;
                        REPORT.Run(39005528);
                        Rec.Reset;
                    end;
                }
            }
        }
    }
}

