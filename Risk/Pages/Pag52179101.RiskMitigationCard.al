page 52179101 "Risk Mitigation Card"
{
    PageType = Card;
    SourceTable = "Risk Mitigation";
    Caption = 'Risk Mitigation Card';
    
    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General Information';
                
                field("Mitigation ID"; Rec."Mitigation ID")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Risk ID"; Rec."Risk ID")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Mitigation Title"; Rec."Mitigation Title")
                {
                    ApplicationArea = All;
                }
                field("Mitigation Description"; Rec."Mitigation Description")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Action Required"; Rec."Action Required")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
            }
            
            group(Timeline)
            {
                Caption = 'Timeline';
                
                field("Target Date"; Rec."Target Date")
                {
                    ApplicationArea = All;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                }
                field("Actual Completion Date"; Rec."Actual Completion Date")
                {
                    ApplicationArea = All;
                }
            }
            
            group(Responsibility)
            {
                Caption = 'Responsibility & Resources';
                
                field("Responsible Person"; Rec."Responsible Person")
                {
                    ApplicationArea = All;
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = All;
                }
                field("Budget Required"; Rec."Budget Required")
                {
                    ApplicationArea = All;
                }
                field("Budget Amount"; Rec."Budget Amount")
                {
                    ApplicationArea = All;
                }
                field("Actual Cost"; Rec."Actual Cost")
                {
                    ApplicationArea = All;
                }
            }
            
            group(Progress)
            {
                Caption = 'Progress Tracking';
                
                field("Progress %"; Rec."Progress %")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Control Effectiveness"; Rec."Control Effectiveness")
                {
                    ApplicationArea = All;
                }
                field("Days Remaining"; Rec."Days Remaining")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            
            group(Review)
            {
                Caption = 'Review Information';
                
                field("Last Review Date"; Rec."Last Review Date")
                {
                    ApplicationArea = All;
                }
                field("Next Review Date"; Rec."Next Review Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    
    actions
    {
        area(Processing)
        {
            group("Actions")
            {
                Caption = 'Actions';
                
                action(StartImplementation)
                {
                    ApplicationArea = All;
                    Caption = 'Start Implementation';
                    Image = Start;
                    Promoted = true;
                    PromotedCategory = Process;
                    Enabled = Rec.Status = Rec.Status::Not_Started;
                    
                    trigger OnAction()
                    begin
                        Rec.Status := Rec.Status::On_Track;
                        Rec."Start Date" := WorkDate();
                        Rec.Modify();
                        Message('Mitigation implementation started.');
                    end;
                }
                
                action(CompleteImplementation)
                {
                    ApplicationArea = All;
                    Caption = 'Complete Implementation';
                    Image = Completed;
                    Promoted = true;
                    PromotedCategory = Process;
                    Enabled = Rec.Status = Rec.Status::On_Track;
                    
                    trigger OnAction()
                    begin
                        if Confirm('Mark this mitigation as completed?') then begin
                            Rec.Status := Rec.Status::Completed;
                            Rec."Actual Completion Date" := WorkDate();
                            Rec."Progress %" := 100;
                            Rec.Modify();
                            Message('Mitigation marked as completed.');
                        end;
                    end;
                }
                
                action(ReviewEffectiveness)
                {
                    ApplicationArea = All;
                    Caption = 'Review Effectiveness';
                    Image = Review;
                    Promoted = true;
                    PromotedCategory = Process;
                    Enabled = Rec.Status = Rec.Status::Completed;
                    
                    trigger OnAction()
                    begin
                        Rec."Last Review Date" := WorkDate();
                        Rec.Modify();
                        Message('Effectiveness review date updated.');
                    end;
                }
            }
        }
        
        area(Navigation)
        {
            action(ViewRisk)
            {
                ApplicationArea = All;
                Caption = 'View Related Risk';
                Image = View;
                RunObject = page "Risk Register Card";
                RunPageLink = "Risk ID" = field("Risk ID");
                Enabled = Rec."Risk ID" <> '';
            }
        }
    }
}