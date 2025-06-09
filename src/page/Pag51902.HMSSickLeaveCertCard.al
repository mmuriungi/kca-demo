page 52118 "HMS Sick Leave Cert. Card"
{
    PageType = Card;
    SourceTable = "HMS-Off Duty";
    Caption = 'Sick Leave Certificate';

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General Information';
                field("Certificate No."; Rec."Certificate No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Certificate No.';
                }
                field("Certificate Date"; Rec."Certificate Date")
                {
                    ApplicationArea = All;
                    Caption = 'Date';
                }
                field("Treatment No."; Rec."Treatment No.")
                {
                    ApplicationArea = All;
                    Caption = 'Treatment No.';
                    
                    trigger OnValidate()
                    var
                        TreatmentHeader: Record "HMS-Treatment Form Header";
                        Patient: Record "HMS-Patient";
                        Employee: Record "HRM-Employee C";
                        Student: Record Customer;
                    begin
                        if TreatmentHeader.Get(Rec."Treatment No.") then begin
                            Rec."Patient No" := TreatmentHeader."Patient No.";
                            
                            // Get patient details
                            if Patient.Get(TreatmentHeader."Patient No.") then begin
                                if Patient."Student No." <> '' then begin
                                    Rec."Student No." := Patient."Student No.";
                                    if Student.Get(Patient."Student No.") then begin
                                        Rec."Staff Name" := Student.Name;
                                        Rec.Department := Student."Global Dimension 2 Code";
                                    end;
                                end else if Patient."Employee No." <> '' then begin
                                    Rec."Staff No" := Patient."Employee No.";
                                    Rec."PF No." := Patient."Employee No.";
                                    if Employee.Get(Patient."Employee No.") then begin
                                        Rec."Staff Name" := Employee."Search Name";
                                        Rec.Department := Employee."Department Name";
                                    end;
                                end;
                            end;
                        end;
                    end;
                }
            }
            
            group("Patient Details")
            {
                Caption = 'Patient Details';
                field(Title; Rec.Title)
                {
                    ApplicationArea = All;
                    Caption = 'Title';
                }
                field("Staff Name"; Rec."Staff Name")
                {
                    ApplicationArea = All;
                    Caption = 'Name';
                    Editable = false;
                }
                field("PF No."; Rec."PF No.")
                {
                    ApplicationArea = All;
                    Caption = 'PF No.';
                    Visible = PFNoVisible;
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                    Caption = 'Student No.';
                    Visible = StudentNoVisible;
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = All;
                    Caption = 'Department';
                }
            }
            
            group("Leave Details")
            {
                Caption = 'Sick Leave Details';
                field("Sick Leave Duration"; Rec."Sick Leave Duration")
                {
                    ApplicationArea = All;
                    Caption = 'Duration';
                }
                field("Duration Unit"; Rec."Duration Unit")
                {
                    ApplicationArea = All;
                    Caption = 'Unit';
                }
                field("Off Duty Start Date"; Rec."Off Duty Start Date")
                {
                    ApplicationArea = All;
                    Caption = 'Start Date';
                }
                field("Review Date"; Rec."Review Date")
                {
                    ApplicationArea = All;
                    Caption = 'Review Date';
                }
                field("Illness Description"; Rec."Illness Description")
                {
                    ApplicationArea = All;
                    Caption = 'Illness/Condition';
                    MultiLine = true;
                }
                field("Off Duty Reason Reason"; Rec."Off Duty Reason Reason")
                {
                    ApplicationArea = All;
                    Caption = 'Additional Notes';
                    MultiLine = true;
                }
            }
            
            group("Authorization")
            {
                Caption = 'Authorization';
                field("Chief Medical Officer"; Rec."Chief Medical Officer")
                {
                    ApplicationArea = All;
                    Caption = 'Chief Medical Officer';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Caption = 'Status';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Print Certificate")
            {
                Caption = 'Print Certificate';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    SickLeaveRec: Record "HMS-Off Duty";
                begin
                    SickLeaveRec.Reset();
                    SickLeaveRec.SetRange("Certificate No.", Rec."Certificate No.");
                    if SickLeaveRec.FindFirst() then
                        Report.Run(Report::"HMS Sick Leave Certificate", true, false, SickLeaveRec); 
                end;
            }
            
            action("Mark as Issued")
            {
                Caption = 'Mark as Issued';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                
                trigger OnAction()
                begin
                    if Confirm('Mark this certificate as issued?', false) then begin
                        Rec.Status := Rec.Status::Released;
                        Rec.Modify();
                        Message('Certificate has been marked as issued.');
                    end;
                end;
            }
        }
    }
    
    trigger OnAfterGetRecord()
    begin
        UpdateVisibility();
    end;
    
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Certificate Date" := Today;
        Rec."Created By" := UserId;
        Rec."Created Date" := CurrentDateTime;
        Rec.Status := Rec.Status::New;
    end;
    
    var
        PFNoVisible: Boolean;
        StudentNoVisible: Boolean;
        
    local procedure UpdateVisibility()
    begin
        PFNoVisible := Rec."PF No." <> '';
        StudentNoVisible := Rec."Student No." <> '';
    end;
}