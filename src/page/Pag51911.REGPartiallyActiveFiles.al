page 51911 "REG-Partially Active Files"
{
    PageType = Document;
    SourceTable = "REG-Registry Files";
    SourceTableView = WHERE("File Status" = FILTER("Partially Active"));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("File No."; Rec."File No.")
                {
                    ApplicationArea = All;
                }
                field("File Subject/Description"; Rec."File Subject/Description")
                {
                    ApplicationArea = All;
                }
                field("Date Created"; Rec."Date Created")
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("File Type"; Rec."File Type")
                {
                    ApplicationArea = All;
                }
                field("Maximum Allowable Files"; Rec."Maximum Allowable Files")
                {
                    ApplicationArea = All;
                }
                field("Date of Issue"; Rec."Date of Issue")
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
                field("Delivery Officer"; Rec."Delivery Officer")
                {
                    ApplicationArea = All;
                }
                field("File Status"; Rec."File Status")
                {
                    ApplicationArea = All;
                }
                field("Dispatch Status"; Rec."Dispatch Status")
                {
                    ApplicationArea = All;
                }
            }
        }
        /* area(factboxes)
        {
            systempart(;Notes)
            {
            }
            systempart(;MyNotes)
            {
            }
            systempart(;Links)
            {
            }
        } */
    }

    actions
    {
        area(creation)
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
        }
    }
}

