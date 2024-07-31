page 54271 "FLT-Submitted Transport List"
{
    CardPageID = "FLT-Submitted Transport Req";
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "FLT-Transport Requisition";
    SourceTableView = WHERE(Status = FILTER(<> Open),
                            Status = FILTER(<> Approved));

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
                        DocumentType := DocumentType::TR;
                        ApprovalEntries.SetRecordFilters(DATABASE::"FLT-Transport Requisition", DocumentType, Rec."Transport Requisition No");
                        ApprovalEntries.Run;
                    end;
                }
                action(cancellsApproval)
                {
                    Caption = 'Cancel Approval Re&quest';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        //ApprovalMgt: Codeunit "Approvals Management";
                        showmessage: Boolean;
                        ManualCancel: Boolean;
                        State: Option Open,"Pending Approval",Cancelled,Approved;
                        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application","Staff Advance","Staff Advance Accounting";
                        tableNo: Integer;
                    begin
                        DocType := DocType::TR;
                        showmessage := true;
                        ManualCancel := true;
                        Clear(tableNo);
                        tableNo := 52018054;
                        // if ApprovalMgt.CancelApproval(tableNo,DocType,Rec."Transport Requisition No",showmessage,ManualCancel) then;
                    end;
                }
                separator(Separator25)
                {
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
        // UserMgt: Codeunit "User Setup Management BR";
        //ApprovalMgt: Codeunit "Approvals Management";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application";
        ApprovalEntries: Page "Approval Entries";
        UserSetup2: Record "User Setup";
        hremp: Record "HRM-Employee C";
        UserSetup3: Record "User Setup";
}

