page 51163 "Receipt Buffer Lines"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "ACA-Imp. Receipts Buffer";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Transaction Code"; Rec."Transaction Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                // field("Batch No."; Rec."Batch No.")
                // {
                //     ApplicationArea = All;
                // }
                field("User ID"; rec."User ID")
                {
                    ApplicationArea = All;
                    Editable = vareditable;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                    Editable = vareditable;
                }
                field("Student No."; Rec."Student No.")
                {
                    Caption = 'Account No.';
                    ApplicationArea = All;
                    Editable = vareditable;

                    trigger OnValidate()
                    var
                        cust: Record Customer;
                    begin
                        cust.Get(Rec."Student No.");
                        Rec.Name := cust.Name;
                    end;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Editable = vareditable;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    Editable = vareditable;
                }

                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                    Editable = false;

                }
                // field("Receipt No"; Rec."Receipt No")
                // {
                //     ApplicationArea = All;
                // }
                // field(IDNo; Rec.IDNo)
                // {
                //     ApplicationArea = All;
                // }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    Editable = vareditable;
                }
                field("Cheque No"; Rec."Cheque No")
                {
                    ApplicationArea = All;
                    Editable = vareditable;
                }
                field("Stud Exist"; Rec."Stud Exist")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
            }
        }

    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
    var
        vareditable: Boolean;

    trigger OnOpenPage()
    begin
        if Rec.Posted = true then
            vareditable := false
        else
            vareditable := true;
    end;
}