page 55154 "REG-Registry Files Card"
{
    PageType = Card;
    SourceTable = "REG-Registry Files";
    SourceTableView = WHERE("File Status" = FILTER(New));

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
                field("Date Closed"; Rec."Date Closed")
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
                field("Issuing Office Name"; Rec."Issuing Office Name")
                {
                    ApplicationArea = All;
                }
                field("Recieving Officer Name"; Rec."Recieving Officer Name")
                {
                    ApplicationArea = All;
                }
                field("Delivery Officer Name"; Rec."Delivery Officer Name")
                {
                    ApplicationArea = All;
                }
                field("Folio No"; Rec."Folio No")
                {
                    ApplicationArea = All;
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = All;
                }
            }
        }
        /* area(factboxes)
        {
            systempart(; Notes)
            {
            }
            systempart(; MyNotes)
            {
            }
            systempart(; Links)
            {
            }
        } */
    }

    actions
    {
        area(creation)
        {
            action("Dispatch ")
            {
                Caption = 'Dispatch File';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF (CONFIRM('Dispatch File?', TRUE) = FALSE) THEN ERROR('Cancelled!');
                    Rec."Dispatch Status" := Rec."Dispatch Status"::Dispatched;
                    Rec.MODIFY;
                    MESSAGE('File Dispatched!')
                end;
            }
            action(Archive)
            {
                Caption = 'Archive File';
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

