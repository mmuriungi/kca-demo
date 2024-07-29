page 55130 "REG-Arch.Registry Files Card"
{
    Editable = false;
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
        area(factboxes)
        {
            systempart(N; Notes)
            {
                ApplicationArea = All;
            }
            systempart(M; MyNotes)
            {
                ApplicationArea = All;
            }
            systempart(L; Links)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(active)
            {
                Caption = 'Set as Active';
                Image = ActivateDiscounts;
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF (CONFIRM('Mark as Active?', TRUE) = FALSE) THEN ERROR('Cancelled!');
                    Rec."File Status" := Rec."File Status"::Active;
                    Rec.MODIFY;
                    MESSAGE('File set as Active!')
                end;
            }
            action(Bring_up)
            {
                Caption = 'Mark as Bring-up';
                Image = History;
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF CONFIRM('Mark as Bring-Up?', FALSE) = FALSE THEN EXIT;

                    Rec."File Status" := Rec."File Status"::Bring_up;
                    Rec.MODIFY;
                    MESSAGE('Set as Bring-up!');
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
        }
    }
}

