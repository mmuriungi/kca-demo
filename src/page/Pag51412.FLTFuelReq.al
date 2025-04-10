page 51412 "FLT-Fuel Req."
{
    PageType = Document;
    SourceTable = "FLT-Fuel & Maintenance Req.";
    SourceTableView = WHERE(Status = FILTER(Open));


    layout
    {
        area(content)
        {
            group(General)
            {
                field("Requisition No"; Rec."Requisition No")
                {
                    ApplicationArea = All;
                }
                field("Vehicle Reg No"; Rec."Vehicle Reg No")
                {
                    ApplicationArea = All;
                }
                field("Driver Number"; Rec.Driver)
                {
                    ApplicationArea = All;
                }
                field("Driver Name"; Rec."Driver Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Vendor(Dealer)"; Rec."Vendor(Dealer)")
                {

                }
                field(vendorName; Rec."Vendor Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }

                field("Odometer Reading"; Rec."Odometer Reading")
                {
                    ApplicationArea = All;
                }
                field("Request Date"; Rec."Request Date")
                {
                    ApplicationArea = All;
                }
                field("Date Taken for Fueling"; Rec."Date Taken for Fueling")
                {
                    ApplicationArea = All;
                }
                field("Time Fuel Is Required"; rec."Time Fuel Is Required")
                {
                    ApplicationArea = all;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Prepared By"; Rec."Prepared By")
                {
                    ApplicationArea = All;
                }
                field("Closed By"; Rec."Closed By")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Date Closed"; Rec."Date Closed")
                {
                    ApplicationArea = All;
                }
                field("Vendor Invoice No"; Rec."Vendor Invoice No")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Posted Invoice No"; Rec."Posted Invoice No")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Purpose; rec.Description)
                {
                    Caption = 'purpose';
                    ApplicationArea = All;
                }
                field(Department; Rec.Department)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("No. Series"; Rec."No. Series")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Date Taken for Maintenance"; Rec."Date Taken for Maintenance")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("Type of Maintenance"; Rec."Type of Maintenance")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Driver; Rec.Driver)
                {
                    Visible = false;
                    ApplicationArea = All;
                }


                field("Fixed Asset No"; Rec."Fixed Asset No")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Litres of Oil"; Rec."Litres of Oil")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Quote No"; Rec."Quote No")
                {
                    Visible = false;
                    ApplicationArea = All;
                }

                field("Type of Fuel"; Rec."Type of Fuel")
                {
                    ApplicationArea = All;
                }
                field("Quantity of Fuel(Litres)"; Rec."Quantity of Fuel(Litres)")
                {
                    ApplicationArea = All;
                }
                field("Price/Litre"; Rec."Price/Litre")
                {
                    ApplicationArea = All;
                }
                field("Total Price of Fuel"; Rec."Total Price of Fuel")
                {
                    ApplicationArea = All;
                }

                field(Coolant; Rec.Coolant)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Battery Water"; Rec."Battery Water")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Wheel Alignment"; Rec."Wheel Alignment")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Wheel Balancing"; Rec."Wheel Balancing")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Car Wash"; Rec."Car Wash")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            group(action)
            {
                Caption = 'action';
                action(Submit)
                {
                    ApplicationArea = All;
                    Caption = 'Submit the  request ';
                    Visible = (rec.Status = rec.Status::Open);

                    trigger OnAction()
                    begin
                        rec.status := rec.status::Submitted;
                        CurrPage.Update();
                    end;
                }
                action(approve)
                {
                    ApplicationArea = All;
                    Caption = 'approve the Request';
                    Visible = (rec.Status = rec.Status::Submitted);
                    trigger OnAction()
                    begin
                        rec.status := rec.status::Approved;
                        CurrPage.Update();
                    end;
                }
                action(Close)
                {
                    ApplicationArea = All;
                    Caption = 'Close the Request';
                    Visible = (rec.Status = rec.Status::Approved);
                    trigger OnAction()
                    begin
                        rec.status := rec.status::Closed;

                        CurrPage.Update();
                    end;
                }
            }
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
                        ApprovalEntries.SetRecordFilters(DATABASE::"FLT-Fuel & Maintenance Req.", DocumentType, Rec."Requisition No");
                        ApprovalEntries.Run;
                    end;
                }

                action(Attachments2)
                {
                    ApplicationArea = All;
                    Caption = 'Fuel Receipts Attachments';
                    Promoted = true;
                    PromotedCategory = process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        RecRef: RecordRef;
                        DocumentAttachment: Page "Document Attachment Custom";
                    begin
                        Clear(DocumentAttachment);
                        RecRef.GETTABLE(Rec);
                        DocumentAttachment.OpenForRecReference(RecRef);
                        DocumentAttachment.RUNMODAL;
                    end;
                }

                action(sendApproval)
                {
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                    // ApprovalMgt: Codeunit "Approvals Management";
                    // showmessage: Boolean;
                    // ManualCancel: Boolean;
                    // State: Option Open,"Pending Approval",Cancelled,Approved;
                    // DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application","Staff Advance","Staff Advance Accounting";
                    // tableNo: Integer;
                    begin


                        Rec.TestField(Status, Rec.Status::Open);


                        Rec.Modify;

                        // State:=State::Open;
                        //  if Status<>Status::Open then State:=State::"Pending Approval";
                        //  DocType:=DocType::TR;
                        //  Clear(tableNo);
                        //tableNo:=52018054;
                        //  if ApprovalMgt.SendApproval(tableNo,Rec."Transport Requisition No",DocType,State) then;
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
                        // ApprovalMgt: Codeunit "Approvals Management";
                        // showmessage: Boolean;
                        // ManualCancel: Boolean;
                        // State: Option Open,"Pending Approval",Cancelled,Approved;
                        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application","Staff Advance","Staff Advance Accounting";
                    // tableNo: Integer;
                    begin
                        DocType := DocType::TR;
                        //  showmessage:=true;
                        //  ManualCancel:=true;
                        //  Clear(tableNo);
                        //  tableNo:=52018054;
                        //   if ApprovalMgt.CancelApproval(tableNo,DocType,Rec."Transport Requisition No",showmessage,ManualCancel) then;
                    end;
                }
                separator(Separator28)
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
                        transRe.Reset;
                        transRe.SetFilter(transRe."Requisition No", Rec."Requisition No");
                        if transRe.Find('-') then
                            REPORT.Run(39005723, true, true, transRe);
                        //RESET;
                    end;
                }
            }

        }
    }

    var
        Text0001: Label 'You have not been setup as a Fleet Management User Contact your Systems Administrator';
        //UserMgt: Codeunit "User Setup Management BR";
        //ApprovalMgt: Codeunit "Approvals Management";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application";
        ApprovalEntries: Page "Approval Entries";
        UserSetup2: Record "User Setup";
        emp: Record "HRM-Employee C";
        UserSetup3: Record "User Setup";
        transRe: Record "FLT-Fuel & Maintenance Req.";


}

