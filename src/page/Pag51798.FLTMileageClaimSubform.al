page 52120 "FLT-Mileage Claim Subform"
{
    Caption = 'Mileage Claim Lines';
    PageType = ListPart;
    SourceTable = "FLT-Mileage Claim Lines";
    AutoSplitKey = true;
    
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Travel Date"; Rec."Travel Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date of travel.';
                }
                field("Vehicle Registration No."; Rec."Vehicle Registration No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the vehicle registration number.';
                    
                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field("Vehicle Make"; Rec."Vehicle Make")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the vehicle make.';
                    Editable = false;
                }
                field("Vehicle Model"; Rec."Vehicle Model")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the vehicle model.';
                    Editable = false;
                }
                field("Engine Capacity"; Rec."Engine Capacity")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the engine capacity.';
                    Editable = false;
                }
                field("Starting Point"; Rec."Starting Point")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the starting point of the trip.';
                }
                field("Destination"; Rec."Destination")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the destination of the trip.';
                }
                field("Purpose of Trip"; Rec."Purpose of Trip")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the purpose of the trip.';
                }
                field("Number of Passengers"; Rec."Number of Passengers")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of passengers.';
                }
                field("Distance (KM)"; Rec."Distance (KM)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the estimated distance in kilometers.';
                }
                field("Rate Per KM"; Rec."Rate Per KM")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the approved rate per kilometer.';
                }
                field("Total Cost"; Rec."Total Cost")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total estimated cost.';
                    Editable = false;
                }
                field("Departure Time"; Rec."Departure Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the departure time.';
                }
                field("Return Date"; Rec."Return Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the return date.';
                }
                field("Return Time"; Rec."Return Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the return time.';
                }
                field("Starting Odometer Reading"; Rec."Starting Odometer Reading")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the starting odometer reading.';
                    Visible = ShowActualReadings;
                }
                field("Ending Odometer Reading"; Rec."Ending Odometer Reading")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the ending odometer reading.';
                    Visible = ShowActualReadings;
                }
                field("Actual Distance (KM)"; Rec."Actual Distance (KM)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the actual distance traveled.';
                    Editable = false;
                    Visible = ShowActualReadings;
                }
                field("Actual Total Cost"; Rec."Actual Total Cost")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the actual total cost.';
                    Editable = false;
                    Visible = ShowActualReadings;
                }
                field("Fuel Receipts Attached"; Rec."Fuel Receipts Attached")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if fuel receipts are attached.';
                    Visible = ShowActualReadings;
                }
                field("Maintenance Receipts Attached"; Rec."Maintenance Receipts Attached")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if maintenance receipts are attached.';
                    Visible = ShowActualReadings;
                }
                field("Transport Officer Remarks"; Rec."Transport Officer Remarks")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies transport officer remarks.';
                    Visible = ShowTransportOfficerFields;
                    Editable = TransportOfficerEditable;
                }
                field("Status"; Rec."Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the status of this line.';
                    Editable = false;
                }
            }
        }
    }
    
    actions
    {
        area(Processing)
        {
            action(ApproveLine)
            {
                Caption = 'Approve Line';
                Image = Approve;
                ApplicationArea = All;
                Visible = ShowTransportOfficerFields;
                Enabled = TransportOfficerEditable;
                
                trigger OnAction()
                var
                    Remarks: Text[250];
                begin
                    if Rec.Status <> Rec.Status::Open then
                        Error('Only open lines can be approved.');
                        
                    Remarks := '';
                    // Simple approval without remarks input for now
                    Rec.ApproveLineByTransportOfficer(Remarks);
                    CurrPage.Update(false);
                end;
            }
            
            action(RejectLine)
            {
                Caption = 'Reject Line';
                Image = Reject;
                ApplicationArea = All;
                Visible = ShowTransportOfficerFields;
                Enabled = TransportOfficerEditable;
                
                trigger OnAction()
                var
                    Remarks: Text[250];
                begin
                    if Rec.Status <> Rec.Status::Open then
                        Error('Only open lines can be rejected.');
                        
                    Remarks := 'Rejected by Transport Officer';
                    Rec.RejectLineByTransportOfficer(Remarks);
                    CurrPage.Update(false);
                end;
            }
        }
    }
    
    trigger OnAfterGetCurrRecord()
    begin
        SetControlVisibility();
    end;
    
    trigger OnOpenPage()
    begin
        SetControlVisibility();
    end;
    
    var
        ShowActualReadings: Boolean;
        ShowTransportOfficerFields: Boolean;
        TransportOfficerEditable: Boolean;
    
    local procedure SetControlVisibility()
    var
        MileageClaimHeader: Record "FLT-Mileage Claim Header";
        UserSetup: Record "User Setup";
        IsTransportOfficer: Boolean;
    begin
        if MileageClaimHeader.Get(Rec."Mileage Claim No.") then begin
            ShowActualReadings := MileageClaimHeader."Approval Stage" in [
                MileageClaimHeader."Approval Stage"::"Transport Officer",
                MileageClaimHeader."Approval Stage"::"VC/DVC/Registrar",
                MileageClaimHeader."Approval Stage"::"Fully Approved"
            ];
            
            ShowTransportOfficerFields := MileageClaimHeader."Approval Stage" in [
                MileageClaimHeader."Approval Stage"::"Transport Officer",
                MileageClaimHeader."Approval Stage"::"VC/DVC/Registrar",
                MileageClaimHeader."Approval Stage"::"Fully Approved"
            ];
            
            // Check if current user is transport officer
            if UserSetup.Get(UserId) then begin
                // Add logic to check if user is transport officer
                IsTransportOfficer := true; // Simplified for now
            end;
            
            TransportOfficerEditable := (MileageClaimHeader.Status = MileageClaimHeader.Status::"Pending Approval") and
                                       (MileageClaimHeader."Approval Stage" = MileageClaimHeader."Approval Stage"::"Transport Officer") and
                                       IsTransportOfficer;
        end;
    end;
}