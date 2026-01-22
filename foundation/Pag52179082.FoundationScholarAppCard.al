page 52179086 "Foundation Scholar App Card"
{
    PageType = Card;
    SourceTable = "Foundation Scholarship App.";
    Caption = 'Foundation Scholarship Application Card';
    
    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General Information';
                
                field("Application No."; Rec."Application No.")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Scholarship No."; Rec."Scholarship No.")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Scholarship Name"; Rec."Scholarship Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
            }
            
            group(StudentInfo)
            {
                Caption = 'Student Information';
                
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                }
                field("Student Email"; Rec."Student Email")
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Program"; Rec."Program")
                {
                    ApplicationArea = All;
                }
                field("Year of Study"; Rec."Year of Study")
                {
                    ApplicationArea = All;
                }
                field("GPA"; Rec."GPA")
                {
                    ApplicationArea = All;
                }
            }
            
            group(Financial)
            {
                Caption = 'Financial Information';
                
                field("Financial Need Amount"; Rec."Financial Need Amount")
                {
                    ApplicationArea = All;
                }
                field("Requested Amount"; Rec."Requested Amount")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Awarded Amount"; Rec."Awarded Amount")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
            }
            
            group(Essays)
            {
                Caption = 'Application Essays';
                
                field("Personal Statement"; Rec."Personal Statement")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Financial Circumstances"; Rec."Financial Circumstances")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Academic Achievements"; Rec."Academic Achievements")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
            }
            
            group(Review)
            {
                Caption = 'Review Information';
                
                field("Review Date"; Rec."Review Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Reviewed By"; Rec."Reviewed By")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Review Comments"; Rec."Review Comments")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
            }
            
            group(Administration)
            {
                Caption = 'Administration';
                
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Modified By"; Rec."Modified By")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Modified Date"; Rec."Modified Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
    
    actions
    {
        area(Processing)
        {
            group(ReviewProcess)
            {
                Caption = 'Review Process';
                
                action(SubmitForReview)
                {
                    ApplicationArea = All;
                    Caption = 'Submit for Review';
                    Image = SendForApproval;
                    Promoted = true;
                    PromotedCategory = Process;
                    Enabled = Rec.Status = Rec.Status::Draft;
                    
                    trigger OnAction()
                    begin
                        if Confirm('Submit application for review?') then begin
                            Rec.Status := Rec.Status::Submitted;
                            Rec.Modify();
                            Message('Application has been submitted for review.');
                        end;
                    end;
                }
                
                action(StartReview)
                {
                    ApplicationArea = All;
                    Caption = 'Start Review';
                    Image = Start;
                    Promoted = true;
                    PromotedCategory = Process;
                    Enabled = Rec.Status = Rec.Status::Submitted;
                    
                    trigger OnAction()
                    begin
                        Rec.Status := Rec.Status::"Under Review";
                        Rec."Review Date" := WorkDate();
                        Rec."Reviewed By" := UserId;
                        Rec.Modify();
                        Message('Review process started.');
                    end;
                }
                
                action(ApproveApplication)
                {
                    ApplicationArea = All;
                    Caption = 'Approve Application';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    Enabled = Rec.Status = Rec.Status::"Under Review";
                    
                    trigger OnAction()
                    begin
                        if Confirm('Approve this scholarship application?') then begin
                            Rec.Status := Rec.Status::Approved;
                            if Rec."Awarded Amount" = 0 then
                                Rec."Awarded Amount" := Rec."Requested Amount";
                            Rec."Review Date" := WorkDate();
                            Rec."Reviewed By" := UserId;
                            Rec.Modify();
                            Message('Application has been approved.');
                        end;
                    end;
                }
                
                action(RejectApplication)
                {
                    ApplicationArea = All;
                    Caption = 'Reject Application';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Process;
                    Enabled = Rec.Status = Rec.Status::"Under Review";
                    
                    trigger OnAction()
                    begin
                        if Confirm('Reject this scholarship application?') then begin
                            Rec.Status := Rec.Status::Rejected;
                            Rec."Review Date" := WorkDate();
                            Rec."Reviewed By" := UserId;
                            Rec.Modify();
                            Message('Application has been rejected.');
                        end;
                    end;
                }
            }
        }
        
        area(Navigation)
        {
            action(ViewScholarship)
            {
                ApplicationArea = All;
                Caption = 'View Scholarship';
                Image = View;
                RunObject = page "Foundation Scholarship Card";
                RunPageLink = "No." = field("Scholarship No.");
                Enabled = Rec."Scholarship No." <> '';
            }
        }
        
        area(Reporting)
        {
            action(PrintApplication)
            {
                ApplicationArea = All;
                Caption = 'Print Application';
                Image = Print;
                
                trigger OnAction()
                begin
                    Message('Application Details:\n\nStudent: %1\nScholarship: %2\nRequested Amount: %3\nStatus: %4\nGPA: %5', 
                        Rec."Student Name", Rec."Scholarship Name", Rec."Requested Amount", Rec.Status, Rec.GPA);
                end;
            }
        }
    }
}