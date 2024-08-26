page 50673 "Other massPCAs"
{
    PageType = Card;
    SourceTable = prMassPCAHD;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Change Advice Serial No."; Rec."Change Advice Serial No.")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Period Month"; Rec."Period Month")
                {
                    ApplicationArea = All;
                }
                field("Period Year"; Rec."Period Year")
                {
                    ApplicationArea = All;
                }
                field("Payroll Period"; Rec."Payroll Period")
                {
                    ApplicationArea = All;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                }
                field(Effected; Rec.Effected)
                {
                    ApplicationArea = All;
                }
                field("Transaction Code"; Rec."Transaction Code")
                {
                    ApplicationArea = All;
                }
                field(PAyrollCode; Rec.PAyrollCode)
                {
                    ApplicationArea = All;
                }
                field("Other Allowances"; Rec."Other Allowances")
                {
                    ApplicationArea = All;
                }
                field("Allowance Name"; Rec."Allowance Name")
                {
                    ApplicationArea = All;
                }
                part(PCAMassLines; prPCAMassLines)
                {
                    SubPageLink = "Change Advice Serial No." = FIELD("Change Advice Serial No."),
                                  "Transaction Code" = FIELD("Transaction Code"),
                                  "Period Month" = FIELD("Period Month"),
                                  "Period Year" = FIELD("Period Year"),
                                  "Payroll Period" = FIELD("Payroll Period");
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart(Notes; Notes)
            {
                ApplicationArea = All;
            }
            systempart(Links; Links)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Load Lines")
                {
                    Caption = 'Load Lines';
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        objLines.RESET;
                        objLines.SETRANGE(objLines."Change Advice Serial No.", Rec."Change Advice Serial No.");
                        IF objLines.FIND('-') THEN objLines.DELETEALL;

                        objemp.RESET;
                        objemp.SETRANGE(objemp.Status, objemp.Status::Active);
                        IF objemp.FIND('-') THEN BEGIN
                            REPEAT
                                objLines.INIT;
                                objLines."Change Advice Serial No." := Rec."Change Advice Serial No.";
                                objLines."Employee Code" := objemp."No.";
                                objLines."Period Month" := Rec."Period Month";
                                objLines."Period Year" := Rec."Period Year";
                                objLines."Payroll Period" := Rec."Payroll Period";
                                objLines."Transaction Code" := Rec."Transaction Code";
                                objLines."Transaction Name" := Rec."Allowance Name";
                                objemp.GET(objemp."No.");
                                //slagrade.SETRANGE(slagrade."Salary Grade code",objemp."Salary Grade");
                                //slagrade.SETRANGE(
                                IF objemp.FIND('-') THEN BEGIN
                                    objLines.Amount := objEmpTransPCA."Other Allowances";
                                    objLines.INSERT;
                                END;
                            UNTIL objemp.NEXT = 0;
                        END;

                        MESSAGE('Success');
                    end;
                }
                action(Approvals)
                {
                    Caption = 'Approvals';
                    Image = Approvals;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page 658;
                        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application",PCA,StaffMovement,"Medical Claims/General Claims","Tuition waiver","Leave Extension Requisition","Staff Update",Graduation,"Campus Transfer","Programme Transfer","Additional Units",Defferal,StudyMode,ExamRemark,SpecialExam,Supplimentary,MassPCA;
                    begin

                        //DocumentType:=DocumentType::MassPCA;
                        //ApprovalEntries.Setfilters(DATABASE::prMassPCAHD,DocumentType,"Change Advice Serial No.");
                        //ApprovalEntries.RUN;
                        // ApprovalsMgmt.OpenApprovalEntriesPage(Rec.RECORDID)
                    end;
                }
                separator(ApprovalRequests)
                {
                }
                action("Send Approval Request")
                {
                    Caption = 'Send Approval Request';
                    Image = SendApprovalRequest;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit 439;
                        showmessage: Boolean;
                        ManualCancel: Boolean;
                        State: Option Open,"Pending Approval",Cancelled,Approved;
                        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application",PCA,StaffMovement,"Medical Claims/General Claims","Tuition waiver","Leave Extension Requisition","Staff Update",Graduation,"Campus Transfer","Programme Transfer","Additional Units",Defferal,StudyMode,ExamRemark,SpecialExam,Supplimentary,MassPCA;
                        tableNo: Integer;
                    begin
                        //fnCheckEmployeeStatus;

                        //Release Document
                        VarVariant := Rec;
                        // IF CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) THEN
                        //     CustomApprovals.OnSendDocForApproval(VarVariant);
                    end;
                }
                action("Cancel Approval Request")
                {
                    Caption = 'Cancel Approval Request';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit 439;
                        showmessage: Boolean;
                        ManualCancel: Boolean;
                        State: Option Open,"Pending Approval",Cancelled,Approved;
                        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application",PCA,StaffMovement,"Medical Claims/General Claims","Tuition waiver","Leave Extension Requisition","Staff Update",Graduation,"Campus Transfer","Programme Transfer","Additional Units",Defferal,StudyMode,ExamRemark,SpecialExam,Supplimentary,MassPCA;
                        tableNo: Integer;
                    begin
                    end;
                }
                separator(Posting)
                {
                }
            }
            group(Posts)
            {
                Caption = 'Post';
                Visible = false;
                action(Post)
                {
                    Caption = 'Post The Changes';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        IF Rec.Status <> Rec.Status::Approved THEN ERROR('PCA must be approved to continue');

                        mPayrollCode := '';

                        UserSetup.RESET;
                        UserSetup.SETRANGE(UserSetup."User ID", USERID);
                        IF UserSetup.FIND('-') THEN BEGIN
                            //mPayrollCode := UserSetup."Payroll Code";
                        END;

                        objPeriod.RESET;
                        objPeriod.SETRANGE(objPeriod.Closed, FALSE);
                        IF objPeriod.FIND('-') THEN BEGIN
                            intMonth := objPeriod."Period Month";
                            intYear := objPeriod."Period Year";
                            dtPAyrollPeriod := objPeriod."Date Opened";
                        END;


                        IF intMonth <> 1 THEN ERROR('The month should be January');

                        IF CONFIRM('Are you Sure you want to post these changes') THEN BEGIN
                            Rec.Effected := TRUE;

                            objLines.RESET;
                            objLines.SETRANGE(objLines."Change Advice Serial No.", Rec."Change Advice Serial No.");
                            IF objLines.FIND('-') THEN BEGIN
                                REPEAT
                                BEGIN

                                    IF dim1 = '' THEN dim1 := objemp.Region;
                                    IF dim2 = '' THEN dim2 := objemp."Department Code";
                                    // IF dim3 = '' THEN dim3 := objemp.Schools;
                                    // IF dim4 = '' THEN dim4 := objemp.Section;

                                    objEmpTrans.RESET;
                                    objEmpTrans.SETRANGE(objEmpTrans."Employee Code", objLines."Employee Code");
                                    objEmpTrans.SETRANGE(objEmpTrans."Payroll Period", objLines."Payroll Period");
                                    objEmpTrans.SETRANGE(objEmpTrans."Transaction Code", objLines."Transaction Code");
                                    objEmpTrans.SETRANGE(objEmpTrans."Payroll Code", mPayrollCode);
                                    IF objEmpTrans.FIND('-') THEN BEGIN
                                        objEmpTrans."Employee Code" := objLines."Employee Code";
                                        objEmpTrans."Transaction Code" := objLines."Transaction Code";
                                        objEmpTrans."Period Month" := intMonth;
                                        objEmpTrans."Period Year" := intYear;
                                        objEmpTrans."Payroll Period" := dtPAyrollPeriod;
                                        objEmpTrans."Transaction Name" := objLines."Transaction Name";
                                        objEmpTrans.Amount := objLines.Amount;
                                        objEmpTrans."Payroll Period" := objLines."Payroll Period";
                                        objEmpTrans."Payroll Code" := mPayrollCode;
                                        objEmpTrans.MODIFY;
                                    END ELSE BEGIN
                                        objEmpTrans.INIT;
                                        objEmpTrans."Employee Code" := objLines."Employee Code";
                                        objEmpTrans."Transaction Code" := objLines."Transaction Code";
                                        objEmpTrans."Period Month" := intMonth;
                                        objEmpTrans."Period Year" := intYear;
                                        objEmpTrans."Payroll Period" := dtPAyrollPeriod;
                                        objEmpTrans."Transaction Name" := objLines."Transaction Name";
                                        objEmpTrans.Amount := objLines.Amount;
                                        objEmpTrans."Payroll Period" := objLines."Payroll Period";
                                        objEmpTrans."Payroll Code" := mPayrollCode;
                                        objEmpTrans.INSERT;
                                    END;
                                END;
                                UNTIL objLines.NEXT = 0;
                            END;

                            Rec.Effected := TRUE;
                            Rec.Status := Rec.Status::Posted;
                            Rec.MODIFY;

                            MESSAGE('These changes has been uploaded to the current payroll');
                        END;
                    end;
                }
            }
        }
    }

    var
        objemp: Record "HRM-Employee C";
        objLines: Record prMassPCALines;
        slagrade: Record "HRM-Salary Grades";
        objPeriod: Record "PRL-Payroll Periods";
        uSetup: Record 91;
        mPayrollCode: Code[50];
        objEmpTrans: Record "PRL-Period Transactions";
        objEmpTransPCA: Record prMassPCAHD;
        intMonth: Integer;
        intYear: Integer;
        dtPAyrollPeriod: Date;
        dim1: Code[50];
        dim2: Code[50];
        dim3: Code[50];
        dim4: Code[50];
        UserSetup: Record 91;
        VarVariant: Variant;
        CustomApprovals: Codeunit "Work Flow Code";
        ApprovalsMgmt: Codeunit "Work Flow Code";
}

