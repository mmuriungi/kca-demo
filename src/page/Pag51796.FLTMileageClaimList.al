page 52119 "FLT-Mileage Claim List"
{
    Caption = 'Transport Mileage Claims';
    PageType = List;
    SourceTable = "FLT-Mileage Claim Header";
    CardPageID = "FLT-Mileage Claim Card";
    ApplicationArea = All;
    UsageCategory = Lists;
    
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the mileage claim number.';
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
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the name of the claiming officer.';
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the department or school.';
                }
                field(Designation; Rec.Designation)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the designation of the employee.';
                }
                field("Total Estimated Mileage"; Rec."Total Estimated Mileage")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total estimated mileage in kilometers.';
                }
                field("Total Estimated Cost"; Rec."Total Estimated Cost")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total estimated cost.';
                }
                field("Approved Rate Per Km"; Rec."Approved Rate Per Km")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the approved rate per kilometer.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the current status of the mileage claim.';
                }
                field("Approval Stage"; Rec."Approval Stage")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the current approval stage.';
                }
                field("Requested By"; Rec."Requested By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies who requested the mileage claim.';
                }
                field("Date Created"; Rec."Date Created")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the mileage claim was created.';
                }
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
                var
                VariantRec: Variant;
                Approv: Codeunit "Approval Workflows V1";
                begin
                    VariantRec := Rec;
                    if Approv.CheckApprovalsWorkflowEnabled(VariantRec) then begin
                        Approv.OnSendDocForApproval(VariantRec);
                    end;
                end;
            }
            
            // action(ApproveByTransportOfficer)
            // {
            //     Caption = 'Approve (Transport Officer)';
            //     Image = Approve;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     PromotedIsBig = true;
            //     ApplicationArea = All;
            //     Visible = TransportOfficerVisible;
            //     Enabled = TransportOfficerEnabled;
                
            //     trigger OnAction()
            //     begin
            //         Rec.ApproveByTransportOfficer();
            //         CurrPage.Update(false);
            //     end;
            // }
            
            // action(FinalApproval)
            // {
            //     Caption = 'Final Approval';
            //     Image = Approve;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     PromotedIsBig = true;
            //     ApplicationArea = All;
            //     Visible = FinalApproverVisible;
            //     Enabled = FinalApproverEnabled;
                
            //     trigger OnAction()
            //     begin
            //         Rec.FinalApproval();
            //         CurrPage.Update(false);
            //     end;
            // }
        }
        
        area(Reporting)
        {
            action(PrintPreview)
            {
                Caption = 'Print/Preview';
                Image = PrintReport;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                ApplicationArea = All;
                
                trigger OnAction()
                var
                    MileageClaimHeader: Record "FLT-Mileage Claim Header";
                begin
                    MileageClaimHeader.Copy(Rec);
                    CurrPage.SetSelectionFilter(MileageClaimHeader);
                    Report.RunModal(Report::"FLT-Mileage Claim Form", true, true, MileageClaimHeader);
                end;
            }
        }
        
        area(Navigation)
        {
            action(MileageClaimLines)
            {
                ApplicationArea = All;
                Caption = 'Lines';
                Image = AllLines;
                RunObject = Page "FLT-Mileage Claim Subform";
                RunPageLink = "Mileage Claim No." = field("No.");
                PromotedCategory = Process;
                Promoted = true;
            }
        }
    }
    
    trigger OnAfterGetRecord()
    begin
        SetControlStates();
    end;
    
    trigger OnAfterGetCurrRecord()
    begin
        SetControlStates();
    end;
    
    trigger OnOpenPage()
    begin
        SetControlStates();
    end;
    
    var
        TransportOfficerVisible: Boolean;
        FinalApproverVisible: Boolean;
        TransportOfficerEnabled: Boolean;
        FinalApproverEnabled: Boolean;
        SendForApprovalEnabled: Boolean;
    
    local procedure SetControlStates()
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
        
        // Set control visibility and enablement
        TransportOfficerVisible := Rec."Approval Stage" in [Rec."Approval Stage"::"Transport Officer", 
                                                           Rec."Approval Stage"::"VC/DVC/Registrar", 
                                                           Rec."Approval Stage"::"Fully Approved"];
        
        FinalApproverVisible := Rec."Approval Stage" in [Rec."Approval Stage"::"VC/DVC/Registrar", 
                                                         Rec."Approval Stage"::"Fully Approved"];
        
        SendForApprovalEnabled := (Rec.Status = Rec.Status::Open) and (Rec."Requested By" = UserId);
        
        TransportOfficerEnabled := (Rec.Status = Rec.Status::"Pending Approval") and 
                                   (Rec."Approval Stage" = Rec."Approval Stage"::"Transport Officer") and 
                                   IsTransportOfficer;
        
        FinalApproverEnabled := (Rec.Status = Rec.Status::"Pending Approval") and 
                                (Rec."Approval Stage" = Rec."Approval Stage"::"VC/DVC/Registrar") and 
                                IsFinalApprover;
    end;
}