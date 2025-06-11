page 52121 "FLT-Mileage Claim Card"
{
    Caption = 'Transport Mileage Claim Form';
    PageType = Document;
    SourceTable = "FLT-Mileage Claim Header";
    
    layout
    {
        area(Content)
        {
            group("PART ONE: APPLICANT")
            {
                Caption = 'PART ONE: APPLICANT';
                
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the mileage claim number.';
                    Editable = false;
                }
                field("Date"; Rec."Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date of the mileage claim request.';
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employee number.';
                    
                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the name of the claiming officer.';
                    Editable = false;
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the department or school.';
                    Editable = false;
                }
                field(Designation; Rec.Designation)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the designation of the employee.';
                    Editable = false;
                }
                field("Phone Number"; Rec."Phone Number")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the contact number.';
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the current status of the mileage claim.';
                    Editable = false;
                }
                field("Approval Stage"; Rec."Approval Stage")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the current approval stage.';
                    Editable = false;
                }
                field("Total Estimated Mileage"; Rec."Total Estimated Mileage")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total estimated mileage in kilometers.';
                    Editable = false;
                }
                field("Total Estimated Cost"; Rec."Total Estimated Cost")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total estimated cost.';
                    Editable = false;
                }
            }
            
            group("PART TWO: TRANSPORT OFFICER")
            {
                Caption = 'PART TWO: TRANSPORT OFFICER';
                Visible = TransportOfficerVisible;
                
                field("Approved Rate Per Km"; Rec."Approved Rate Per Km")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the approved rate per kilometer.';
                    Editable = TransportOfficerEditable;
                }
                field("Transport Officer"; Rec."Transport Officer")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the transport officer.';
                    Editable = false;
                }
                field("Transport Officer Date"; Rec."Transport Officer Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date approved by transport officer.';
                    Editable = false;
                }
            }
            
            group("PART THREE: VC/DVC/REGISTRAR")
            {
                Caption = 'PART THREE: VC/DVC/REGISTRAR';
                Visible = FinalApproverVisible;
                
                field("Approver Name"; Rec."Approver Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the final approver name.';
                    Editable = false;
                }
                field("Approved Date"; Rec."Approved Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the final approval date.';
                    Editable = false;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies any remarks.';
                    MultiLine = true;
                    Editable = FinalApproverEditable;
                }
            }
            
            part(MileageClaimLines; "FLT-Mileage Claim Subform")
            {
                ApplicationArea = All;
                SubPageLink = "Mileage Claim No." = field("No.");
                UpdatePropagation = Both;
                Editable = LinesEditable;
            }
        }
        area(FactBoxes)
        {
            systempart(Notes; Notes)
            {
                ApplicationArea = All;
            }
            systempart(RecordLinks; Links)
            {
                ApplicationArea = All;
            }
        }
    }
    
    actions
    {
        area(Processing)
        {
            action(SendForApproval)
            {
                Caption = 'Send for Approval';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;
                Enabled = SendForApprovalEnabled;
                
                trigger OnAction()
                begin
                    Rec.SendForApproval();
                    CurrPage.Update(false);
                end;
            }
            
            action(ApproveByTransportOfficer)
            {
                Caption = 'Approve (Transport Officer)';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;
                Visible = TransportOfficerVisible;
                Enabled = TransportOfficerEditable;
                
                trigger OnAction()
                begin
                    Rec.ApproveByTransportOfficer();
                    CurrPage.Update(false);
                end;
            }
            
            action(FinalApproval)
            {
                Caption = 'Final Approval';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;
                Visible = FinalApproverVisible;
                Enabled = FinalApproverEditable;
                
                trigger OnAction()
                begin
                    Rec.FinalApproval();
                    CurrPage.Update(false);
                end;
            }
            
            action(PrintPreview)
            {
                Caption = 'Print/Preview';
                Image = PrintReport;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                ApplicationArea = All;
                
                trigger OnAction()
                begin
                    // Report will be created later
                    Message('Mileage Claim Form report will be available once created.');
                end;
            }
            
            action(Attachments)
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                Image = Attach;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                
                trigger OnAction()
                begin
                    // Document attachments functionality
                    Message('Document attachments functionality will be available.');
                end;
            }
        }
        
        area(Navigation)
        {
            action(Dimensions)
            {
                ApplicationArea = All;
                Caption = 'Dimensions';
                Image = Dimensions;
                
                trigger OnAction()
                begin
                    // Dimensions functionality
                    Message('Dimensions functionality will be available.');
                end;
            }
        }
    }
    
    trigger OnAfterGetCurrRecord()
    begin
        SetControlVisibility();
        SetControlEditable();
    end;
    
    trigger OnOpenPage()
    begin
        SetControlVisibility();
        SetControlEditable();
    end;
    
    var
        TransportOfficerVisible: Boolean;
        FinalApproverVisible: Boolean;
        TransportOfficerEditable: Boolean;
        FinalApproverEditable: Boolean;
        LinesEditable: Boolean;
        SendForApprovalEnabled: Boolean;
    
    local procedure SetControlVisibility()
    begin
        TransportOfficerVisible := Rec."Approval Stage" in [Rec."Approval Stage"::"Transport Officer", 
                                                           Rec."Approval Stage"::"VC/DVC/Registrar", 
                                                           Rec."Approval Stage"::"Fully Approved"];
        
        FinalApproverVisible := Rec."Approval Stage" in [Rec."Approval Stage"::"VC/DVC/Registrar", 
                                                         Rec."Approval Stage"::"Fully Approved"];
    end;
    
    local procedure SetControlEditable()
    var
        UserSetup: Record "User Setup";
        IsTransportOfficer: Boolean;
        IsFinalApprover: Boolean;
    begin
        // Check if current user is transport officer
        if UserSetup.Get(UserId) then begin
            // Add logic to check if user is transport officer
            IsTransportOfficer := true; // Simplified for now
        end;
        
        // Check if current user is final approver (VC/DVC/Registrar)
        IsFinalApprover := true; // Simplified for now
        
        // Set editability based on status and user role
        LinesEditable := Rec.Status = Rec.Status::Open;
        SendForApprovalEnabled := (Rec.Status = Rec.Status::Open) and (Rec."Requested By" = UserId);
        
        TransportOfficerEditable := (Rec.Status = Rec.Status::"Pending Approval") and 
                                   (Rec."Approval Stage" = Rec."Approval Stage"::"Transport Officer") and 
                                   IsTransportOfficer;
        
        FinalApproverEditable := (Rec.Status = Rec.Status::"Pending Approval") and 
                                (Rec."Approval Stage" = Rec."Approval Stage"::"VC/DVC/Registrar") and 
                                IsFinalApprover;
    end;
}