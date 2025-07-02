page 50271 "Audit Recommendation Card"
{
    ApplicationArea = All;
    Caption = 'Audit Recommendation Card';
    PageType = Card;
    SourceTable = "Audit Recommendations";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the entry number of the audit recommendation.';
                    Editable = false;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the document number associated with this audit recommendation.';
                }
                field("Audit Observation"; Rec."Audit Observation")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the audit observation.';
                    MultiLine = true;
                }
                field("Audit Recommendation"; Rec."Audit Recommendation")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the audit recommendation.';
                    MultiLine = true;
                }
                field("Department Responsible"; Rec."Department Responsible")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the department responsible for implementing the recommendation.';
                }
                field("Department Name"; Rec."Department Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the name of the department responsible for implementation.';
                }
                field("Implementation Date"; Rec."Implementation Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date by which the recommendation should be implemented.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the status of the recommendation implementation.';
                }
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies any comments regarding the implementation of the recommendation.';
                    MultiLine = true;
                }
                field("Management Response"; Rec."Management Response")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the management response to this recommendation.';
                    MultiLine = true;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(MarkAsImplemented)
            {
                ApplicationArea = All;
                Caption = 'Mark as Implemented';
                Image = Completed;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Mark this recommendation as implemented.';

                trigger OnAction()
                begin
                    Rec.Status := Rec.Status::Implemented;
                    Rec.Modify();
                end;
            }
        }
    }
}
