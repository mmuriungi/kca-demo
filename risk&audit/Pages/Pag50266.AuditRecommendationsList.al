page 50268 "Audit Recommendations List"
{
    ApplicationArea = All;
    Caption = 'Audit Recommendations List';
    PageType = List;
    SourceTable = "Audit Recommendations";
    UsageCategory = Lists;
    CardPageID = "Audit Recommendation Card";
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the entry number of the audit recommendation.';
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
                }
                field("Audit Recommendation"; Rec."Audit Recommendation")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the audit recommendation.';
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
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the comments for the recommendation.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the status of the recommendation implementation.';
                }
            }
        }
    }
    
    actions
    {
        area(Processing)
        {
            action(Edit)
            {
                ApplicationArea = All;
                Caption = 'Edit';
                Image = Edit;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Edit the selected recommendation.';
                
                trigger OnAction()
                begin
                    
                end;
            }
        }
    }
}
