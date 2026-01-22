page 51898 "REG-Inbound Mails (Sort.) Card"
{
    DeleteAllowed = true;
    Editable = true;
    InsertAllowed = true;
    PageType = Card;
    SourceTable = "REG-Mail Register";
    SourceTableView = WHERE("Direction Type" = FILTER('Incoming Mail (Internal)' | 'Incoming Mail (External)'),
                            "Mail Status" = FILTER('Sorting'));

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = All;
                }
                field("Subject of Doc."; Rec."Subject of Doc.")
                {
                    ApplicationArea = All;
                }
                field("Mail Date"; Rec."Mail Date")
                {
                    ApplicationArea = All;
                }
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = All;
                }
                field("Doc type"; Rec."Doc type")
                {
                    ApplicationArea = All;
                }
                field("Cheque Amount"; Rec."Cheque Amount")
                {
                    ApplicationArea = All;
                }
                field("Direction Type"; Rec."Direction Type")
                {
                    ApplicationArea = All;
                }
                field(Received; Rec.Received)
                {
                    ApplicationArea = All;
                }
                field("Doc Ref No."; Rec."Doc Ref No.")
                {
                    ApplicationArea = All;
                }
                field("File Tab"; Rec."File Tab")
                {
                    ApplicationArea = All;
                }
                field("Person Recording"; Rec."Person Recording")
                {
                    ApplicationArea = All;
                }
                field("Delivered By (Mail)"; Rec."Delivered By (Mail)")
                {
                    ApplicationArea = All;
                }
                field("Delivered By (Phone)"; Rec."Delivered By (Phone)")
                {
                    ApplicationArea = All;
                }
                field("Delivered By (Name)"; Rec."Delivered By (Name)")
                {
                    ApplicationArea = All;
                }
                field("Delivered By (ID)"; Rec."Delivered By (ID)")
                {
                    ApplicationArea = All;
                }
                field("Delivered By (Town)"; Rec."Delivered By (Town)")
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
            action(Sort)
            {
                Caption = 'Mark as Sorted Mail';
                Image = ClearLog;
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin

                    IF (CONFIRM('Mark mail as Sorted?', TRUE) = TRUE) THEN BEGIN
                        Rec."Mail Status" := Rec."Mail Status"::Sorted;
                        Rec.MODIFY;
                    END;
                    MESSAGE('Successfully Sorted.');
                end;
            }
        }
    }
}

