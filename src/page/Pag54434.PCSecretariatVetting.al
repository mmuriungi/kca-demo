page 54434 "PC Secretariat Vetting"
{
    Caption = 'PC Secretariat Vetting';
    PageType = Card;
    SourceTable = "DepartMent Work Plan";
    //SourceTableView = where(Incharge = const(HOD));
    layout
    {
        area(Content)
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
                field("Plan Year"; Rec."Plan Year")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Plan Year field.';
                }
                field("Department Name"; Rec."Department Name")
                {

                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Department Name field.';
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Created By field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field(Incharge; Rec.Incharge)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Incharge field.';
                    Editable = false;
                }

            }
            // part(Line; "WorkPlan Lines")
            // {
            //     UpdatePropagation = Both;
            //     ApplicationArea = All;
            //     SubPageLink = "Document No." = field("No.");
            // }
            part("Department Line"; "Departmental Activities1")
            {
                UpdatePropagation = Both;
                ApplicationArea = All;
                SubPageLink = "Document No." = field("No.");
            }
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
            action("Send Divisional PC for Approval ")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = SendTo;
                trigger OnAction()
                begin
                    Rec.Incharge := Rec.Incharge::"Executive committee";
                    Rec.Modify();
                end;
            }
        }

    }

}
