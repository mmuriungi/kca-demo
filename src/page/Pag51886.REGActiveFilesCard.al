page 51886 "REG-Active Files Card"
{
    PageType = Document;
    SourceTable = "REG-Registry Files";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("File No."; Rec."File No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("File Subject/Description"; Rec."File Subject/Description")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Date Created"; Rec."Date Created")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("File Type"; Rec."File Type")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Maximum Allowable Files"; Rec."Maximum Allowable Files")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Date of Issue"; Rec."Date of Issue")
                {
                    ApplicationArea = All;
                }
                field("File Status"; Rec."File Status")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Requisition No"; Rec."Requisition No")
                {
                    ApplicationArea = All;
                }
                field("Issuing Officer"; Rec."Issuing Officer")
                {
                    ApplicationArea = All;
                }
                field("Circulation Reason"; Rec."Circulation Reason")
                {
                    ApplicationArea = All;
                }
                field("Expected Return Date"; Rec."Expected Return Date")
                {
                    ApplicationArea = All;
                }
                field("Receiving Officer"; Rec."Receiving Officer")
                {
                    ApplicationArea = All;
                }
                field("Receiving Office"; Rec."Receiving Office")
                {
                    ApplicationArea = All;
                }
                field("Dispatch Status"; Rec."Dispatch Status")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart(p1; Notes)
            {
                ApplicationArea = All;
            }
            systempart(p2; MyNotes)
            {
                ApplicationArea = All;
            }
            systempart(Links; Links)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Bringup)
            {
                Caption = 'Set as Bring-up';
                Image = History;
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF (CONFIRM('Mark as Bring-up?', TRUE) = FALSE) THEN ERROR('Cancelled!');
                    Rec."File Status" := Rec."File Status"::Bring_up;
                    Rec.MODIFY;
                    MESSAGE('File set as Bring-up!')
                end;
            }
            action(Archive)
            {
                Caption = 'Archive File';
                Image = Archive;
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF CONFIRM('Archive File?', FALSE) = FALSE THEN EXIT;

                    Rec."File Status" := Rec."File Status"::Archived;
                    Rec.MODIFY;
                    MESSAGE('File archived!');
                end;
            }
            action(part_act)
            {
                Caption = 'Partially Active';
                Image = AdjustItemCost;
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF CONFIRM('Set As Partially Active?', FALSE) = FALSE THEN EXIT;

                    Rec."File Status" := Rec."File Status"::"Partially Active";
                    Rec.MODIFY;
                    MESSAGE('File set as Partially Active');
                end;
            }
            separator(sep)
            {
            }
            action("Dispatch ")
            {
                Caption = 'Dispatch File';
                Image = Delivery;
                Promoted = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF (CONFIRM('Dispatch File?', TRUE) = FALSE) THEN ERROR('Cancelled!');
                    Rec."Dispatch Status" := Rec."Dispatch Status"::Dispatched;
                    Rec.MODIFY;
                    MESSAGE('File Dispatched!')
                end;
            }
        }
    }
}

