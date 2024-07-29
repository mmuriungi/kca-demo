page 54428 "WorkPlan Exec Committee Card"
{
    Caption = 'Work Plan Executive Committee ';
    PageType = Card;
    SourceTable = "DepartMent Work Plan";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Date"; Rec."Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Department field.';
                }
                field("Department Name"; Rec."Department Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Department Name field.';
                }
                // field(Incharge; Rec.Incharge)
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the Incharge field.';
                // }
                // field(Status; Rec.Status)
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the Status field.';
                // }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Created By field.';
                }
            }
            // part(Line; "WorkPlan Lines")
            // {
            //     UpdatePropagation = Both;
            //     ApplicationArea = All;
            //     SubPageLink = "Document No." = field("No.");
            // }
        }
        area(FactBoxes)
        {
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(52413),
                              "No." = FIELD("No.");
            }
            systempart(Link; Links)
            {
                ApplicationArea = RecordLinks;
            }
            systempart(Note; Notes)
            {
                ApplicationArea = Notes;
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Approve Divisional PC")
            {
                ApplicationArea = All;
                Caption = 'Approve Divisional PC';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = SendToMultiple;
                trigger OnAction()
                begin
                    Rec.Status := rec.Status::Released;
                    rec.Modify()
                end;
            }
        }
    }
}
