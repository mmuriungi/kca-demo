page 50672 "prMassPCA Card VW"
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
                field("Transaction Code"; Rec."Transaction Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Transaction Name"; Rec."Transaction Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Period Month"; Rec."Period Month")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Period Year"; Rec."Period Year")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Payroll Period"; Rec."Payroll Period")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = All;
                }
                field(Effected; Rec.Effected)
                {
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
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
    }

    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
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

                        DocumentType := DocumentType::MassPCA;
                        ApprovalEntries.SetRecordFilters(DATABASE::"prBasic pay PCA", DocumentType, Rec."Change Advice Serial No.");
                        ApprovalEntries.RUN;
                    end;
                }
            }
            group(Posting)
            {
                Caption = 'Post';
                Visible = false;
                action(Posts)
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
                            // mPayrollCode := UserSetup."Payroll Code";
                        END;

                        objPeriod.RESET;
                        objPeriod.SETRANGE(objPeriod.Closed, FALSE);
                        IF objPeriod.FIND('-') THEN BEGIN
                            intMonth := objPeriod."Period Month";
                            intYear := objPeriod."Period Year";
                            dtPAyrollPeriod := objPeriod."Date Opened";
                        END;

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
}

