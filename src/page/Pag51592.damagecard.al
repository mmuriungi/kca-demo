page 51592 "damage card"
{
    Caption = 'damage card';
    PageType = Card;
    SourceTable = damages;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("damage number"; Rec."damage number")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the damage number field.', Comment = '%';
                }
                field("Damage Description"; Rec."Damage Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Damage Description field.', Comment = '%';
                }
                field("student  Number"; Rec."student  Number")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the student  Number field.', Comment = '%';
                }
                field("student Name "; Rec."student Name ")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the student Name field.', Comment = '%';
                }
                field("student Email"; Rec."student Email")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the student Email field.', Comment = '%';
                }
                field("student phone number"; Rec."student phone number")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the student phone number field.', Comment = '%';
                }
                field(status; Rec.status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the status field.', Comment = '%';
                }
                field("damage cost "; Rec."damage cost ")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the damage cost field.', Comment = '%';
                }
                field("dvc comment "; Rec."dvc comment ")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the dvc comment field.', Comment = '%';
                }
                field("finance comment "; Rec."finance comment ")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the finance comment field.', Comment = '%';
                }

            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Forward to DVC")
            {
                ApplicationArea = All;
                Visible = rec.status = rec.status::initiated;
                trigger OnAction()
                begin
                    rec.status := rec.status::dvc;
                    Message('forwarded successfully to DVC(ARE) for approval');
                end;
            }
            action("Approve ")
            {
                ApplicationArea = All;
                Visible = rec.status = rec.status::dvc;

                trigger OnAction()
                begin
                    rec.status := rec.status::finance;
                    Message('Approved successfully and forwarded to finance for billing');
                end;
            }
            action("Reject")
            {
                ApplicationArea = All;
                Visible = rec.status = rec.status::dvc;
                trigger OnAction()
                begin
                    rec.status := rec.status::cancel;
                    Message('Canceled successfully');
                end;
            }
            action("Acted upon it")
            {
                ApplicationArea = All;
                Visible = rec.status = rec.status::finance;
                trigger OnAction()
                begin
                    rec.status := rec.status::billed;
                    Message('Student was billed  successfully ');
                end;
            }
        }

    }
}
