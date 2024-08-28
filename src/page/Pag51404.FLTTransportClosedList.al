page 51404 "FLT-Transport - Closed List"
{
    CardPageID = "FLT-Approved transport Req";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "FLT-Transport Requisition";
    SourceTableView = WHERE(Status = FILTER(closed));
    Caption = 'FLT-Transport - Closed List';

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Transport Requisition No"; Rec."Transport Requisition No")
                {
                    ApplicationArea = All;
                }
                field(Commencement; Rec.Commencement)
                {
                    ApplicationArea = All;
                }
                field(Destination; Rec.Destination)
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("Date of Trip"; Rec."Date of Trip")
                {
                    ApplicationArea = All;
                }
                field("No Of Passangers"; Rec."No Of Passangers")
                {
                    ApplicationArea = All;
                }
                field("Authorized  By"; Rec."Authorized  By")
                {
                    ApplicationArea = All;
                }
                field(Position; Rec.Position)
                {
                    ApplicationArea = All;
                }
                field("Transport Officer Remarks"; Rec."Transport Officer Remarks")
                {
                    ApplicationArea = All;
                }
                field("HOD Recommendations"; Rec."HOD Recommendations")
                {
                    ApplicationArea = All;
                }
                field("Finance Officer Comments"; Rec."Finance Officer Comments")
                {
                    ApplicationArea = All;
                }
                field("No of Days Requested"; Rec."No of Days Requested")
                {
                    ApplicationArea = All;
                }
                field("Requested By"; Rec."Requested By")
                {
                    ApplicationArea = All;
                }
                field("Date Requisition Received"; Rec."Date Requisition Received")
                {
                    ApplicationArea = All;
                }
                field("Date of Request"; Rec."Date of Request")
                {
                    ApplicationArea = All;
                }
                field("Time Requisition Received"; Rec."Time Requisition Received")
                {
                    ApplicationArea = All;
                }
                field("P/NO"; Rec."P/NO")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Vehicle Allocated"; Rec."Vehicle Allocated")
                {
                    ApplicationArea = All;
                }
                field("Driver Allocated"; Rec."Driver Allocated")
                {
                    ApplicationArea = All;
                }
                field("Vehicle Allocated by"; Rec."Vehicle Allocated by")
                {
                    ApplicationArea = All;
                }
                field("Opening Odometer Reading"; Rec."Opening Odometer Reading")
                {
                    ApplicationArea = All;
                }
                field("Purpose of Trip"; Rec."Purpose of Trip")
                {
                    ApplicationArea = All;
                }
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("&Functions")
            {
                Caption = '&Functions';
                action(Approvals)
                {
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        DocumentType := DocumentType::TransportRequest;
                        ApprovalEntries.SetRecordFilters(DATABASE::"FLT-Transport Requisition", DocumentType, Rec."Transport Requisition No");
                        ApprovalEntries.Run;
                    end;
                }
                action("Print/Preview")
                {
                    Caption = 'Print/Preview';
                    Image = PrintReport;
                    Promoted = true;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //RESET;
                        //SETFILTER("No.","No.");
                        //REPORT.RUN(39006200,TRUE,TRUE,Rec);
                        //RESET;
                    end;
                }
            }
        }
    }

    var
        Text0001: Label 'You have no been setup as a Fleet Management User Contact your Systems Administrator';
        FltUserSetup: Record "FLT-Mgt Approval Setups";
        ViewPerDepartment: Boolean;
        ApprovalEntries: Page "Approval Entries";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest;
        UserSetup: Record "User Setup";
        VehicleAllocateddpt: Record "FLT-Department Vehicle Alloc";
        WshpFA: Record "FLT-Vehicle Header";
        Vehicleallocated: Record "FLT-Driver Vehicle";
        UserSetup2: Record "User Setup";
        hremp: Record "HRM-Employee C";
        UserSetup3: Record "User Setup";
}

