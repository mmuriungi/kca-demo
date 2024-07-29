page 51221 prPayChangeAdvice
{
    PageType = Card;
    SourceTable = "prBasic pay PCA";

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
                field("Employee Code"; Rec."Employee Code")
                {
                    ApplicationArea = All;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                }
                field("Basic Pay"; Rec."Basic Pay")
                {
                    ApplicationArea = All;
                }
                field("Pays NSSF"; Rec."Pays NSSF")
                {
                    ApplicationArea = All;
                }
                field("Pays NHIF"; Rec."Pays NHIF")
                {
                    ApplicationArea = All;
                }
                field("Pays PAYE"; Rec."Pays PAYE")
                {
                    ApplicationArea = All;
                }
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                }
                field("Payroll Period"; Rec."Payroll Period")
                {
                    ApplicationArea = All;
                }
                field("Region Code"; Rec."Region Code")
                {
                    ApplicationArea = All;
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = All;
                }
                field("School Code"; Rec."School Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Section Code"; Rec."Section Code")
                {
                    visible = false;
                    ApplicationArea = All;
                }
                field("Transfer/Appointment No"; Rec."Transfer/Appointment No")
                {
                    ApplicationArea = All;
                }
            }
            part(Lines; "prEmployee Trans PCA")
            {
                SubPageLink = "Employee Code" = FIELD("Employee Code"),
                              "Change Advice Serial No." = FIELD("Change Advice Serial No."),
                              "Payroll Period" = FIELD("Payroll Period");
                ApplicationArea = All;
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
            systempart(MyNotes; MyNotes)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Approv)
            {
                action(Approvals)
                {
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        ApprovalsMgmt.OpenApprovalEntriesPage(Rec.RECORDID)
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
                        // ApprovalMgt: Codeunit 439;
                        // showmessage: Boolean;
                        // ManualCancel: Boolean;
                        // State: Option Open,"Pending Approval",Cancelled,Approved;
                        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application","Staff Advance","Staff Advance Accounting";
                    // tableNo: Integer;
                    begin

                        Rec.TESTFIELD(Status, Rec.Status::Open);
                        VarVariant := Rec;
                        //IF CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) THEN
                        //    CustomApprovals.OnSendDocForApproval(VarVariant);

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
                        ApprovalMgt: Codeunit 439;
                        showmessage: Boolean;
                        ManualCancel: Boolean;
                        State: Option Open,"Pending Approval",Cancelled,Approved;
                        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application","Staff Advance","Staff Advance Accounting";
                        tableNo: Integer;
                    begin

                        Rec.TESTFIELD(Status, Rec.Status::"Pending Approval");
                        VarVariant := Rec;
                        //CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
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

                        //Get
                        // mPayrollCode := '';
                        // dim1 := '';
                        // dim2 := '';
                        // dim3 := '';
                        // dim4 := '';

                        //-------------------------------------------
                        mPayrollCode := '';

                        UserSetup.RESET;
                        UserSetup.SETRANGE(UserSetup."User ID", USERID);
                        IF UserSetup.FIND('-') THEN BEGIN
                            mPayrollCode := UserSetup."Payroll Code";
                        END;

                        objEmp.RESET;
                        objEmp.SETRANGE(objEmp."No.", Rec."Employee Code");
                        IF objEmp.FIND('-') THEN BEGIN
                            mPayrollCode := objEmp."Payroll Code";
                            dim1 := objEmp."Region";
                            dim2 := objEmp."Department Code";
                            // dim3 := objEmp.Schools;
                            // dim4 := objEmp.Section;
                        END;

                        objPayrollPeriod.RESET;
                        objPayrollPeriod.SETRANGE(objPayrollPeriod.Closed, FALSE);
                        IF objPayrollPeriod.FIND('-') THEN BEGIN
                            intMonth := objPayrollPeriod."Period Month";
                            intYear := objPayrollPeriod."Period Year";
                            dtPAyrollPeriod := objPayrollPeriod."Date Opened";
                        END;

                        IF CONFIRM('Are you Sure you want to post these change for employee ' + Rec."Employee Code" + '-' + Rec."Employee Name") THEN BEGIN
                            objEmpTrans.RESET;
                            objEmpTrans.SETRANGE(objEmpTrans."Employee Code", rec."Employee Code");
                            objEmpTrans.SETRANGE(objEmpTrans."Payroll Period", Rec."Payroll Period");
                            IF objEmpTrans.FIND('-') THEN BEGIN
                                objEmpTrans.DELETEALL(TRUE);
                            END;


                            objSalCard.RESET;
                            objSalCard.SETRANGE(objSalCard."Employee Code", Rec."Employee Code");
                            IF objSalCard.FIND('-') THEN BEGIN //-------------if old employee then Check changes to the basic pay and update-------------
                                objSalCard."Basic Pay" := Rec."Basic Pay";
                                objSalCard."Pays NSSF" := Rec."Pays NSSF";
                                objSalCard."Pays NHIF" := Rec."Pays NHIF";
                                objSalCard."Pays PAYE" := Rec."Pays PAYE";

                                Rec.Effected := TRUE;
                                objSalCard.MODIFY;
                                fnTrackChanges('Change in Basic Salary', FORMAT(xRec."Basic Pay"), FORMAT(Rec."Basic Pay"));
                            END ELSE BEGIN                     //-------------if new employee insert prsalary card---------------------------------------
                                objSalCard.INIT;
                                objSalCard."Employee Code" := Rec."Employee Code";
                                objSalCard."Basic Pay" := Rec."Basic Pay";
                                objSalCard."Payment Mode" := objSalCard."Payment Mode"::"Bank Transfer";
                                objSalCard."Pays NSSF" := TRUE;
                                objSalCard."Pays NHIF" := TRUE;
                                objSalCard."Pays PAYE" := TRUE;
                                objSalCard."Suspend Pay" := FALSE;
                                objSalCard."Suspension Date" := 0D;
                                objSalCard."Suspension Reasons" := '';
                                objSalCard."Posting Group" := 'PAYROLL';

                                objSalCard.INSERT;
                                fnTrackChanges('Change in Basic Salary', FORMAT(xRec."Basic Pay"), FORMAT(Rec."Basic Pay"));
                            END;
                            //-------------if transaction is new insert new-------------------------------------------
                            objEmpTransPCA.RESET;
                            objEmpTransPCA.SETRANGE(objEmpTransPCA."Employee Code", Rec."Employee Code");
                            objEmpTransPCA.SETRANGE(objEmpTransPCA."Payroll Period", Rec."Payroll Period");
                            objEmpTransPCA.SETRANGE(objEmpTransPCA."Change Advice Serial No.", Rec."Change Advice Serial No.");
                            IF objEmpTransPCA.FIND('-') THEN BEGIN
                                REPEAT
                                BEGIN

                                    dim1 := objEmpTransPCA."Global Dimension 1 Code";
                                    dim2 := objEmpTransPCA."Global Dimension 2 Code";
                                    dim3 := objEmpTransPCA."Shortcut Dimension 3 Code";
                                    dim4 := objEmpTransPCA."Shortcut Dimension 4 Code";

                                    IF dim1 = '' THEN dim1 := objEmp.Region;
                                    IF dim2 = '' THEN dim2 := objEmp."Department Code";
                                    // IF dim3 = '' THEN dim3 := objEmp.Schools;
                                    // IF dim4 = '' THEN dim4 := objEmp.Section;

                                    /* objEmpTrans.RESET;
                                    objEmpTrans.SETRANGE(objEmpTrans."Employee Code", objEmpTransPCA."Employee Code");
                                    objEmpTrans.SETRANGE(objEmpTrans."Payroll Period", objEmpTransPCA."Payroll Period");
                                    objEmpTrans.SETRANGE(objEmpTrans."Transaction Code", objEmpTransPCA."Transaction Code");
                                    objEmpTrans.SETRANGE(objEmpTrans."Payroll Code", mPayrollCode);
                                    //objEmpTrans.SETRANGE(objEmpTrans."Department Code", dim2);
                                    IF objEmpTrans.FIND('-') THEN BEGIN
                                        //   objEmpTrans.CALCFIELDS(objEmpTrans."PI Approval Status");
                                        //    IF objEmpTrans."PI Approval Status"<>objEmpTrans."Status"::Open THEN ERROR('You cannot post changes to since the is NOT open');
                                    END; */

                                    objEmpTrans.RESET;
                                    objEmpTrans.SETRANGE(objEmpTrans."Employee Code", objEmpTransPCA."Employee Code");
                                    objEmpTrans.SETRANGE(objEmpTrans."Payroll Period", objEmpTransPCA."Payroll Period");
                                    objEmpTrans.SETRANGE(objEmpTrans."Transaction Code", objEmpTransPCA."Transaction Code");
                                    objEmpTrans.SETRANGE(objEmpTrans."Payroll Code", mPayrollCode);
                                    IF objEmpTrans.FIND('-') THEN BEGIN
                                        objEmpTrans."Employee Code" := objEmpTransPCA."Employee Code";
                                        objEmpTrans."Transaction Code" := objEmpTransPCA."Transaction Code";
                                        objEmpTrans."Period Month" := intMonth;
                                        objEmpTrans."Period Year" := intYear;
                                        objEmpTrans."Payroll Period" := dtPAyrollPeriod;
                                        objEmpTrans."Transaction Name" := objEmpTransPCA."Transaction Name";
                                        objEmpTrans.Amount := objEmpTransPCA.Amount;
                                        objEmpTrans.Balance := objEmpTransPCA.Balance;
                                        objEmpTrans."Payroll Period" := objEmpTransPCA."Payroll Period";
                                        objEmpTrans."Payroll Code" := mPayrollCode;
                                        objEmpTrans."Department Code" := dim2;
                                        //objEmpTrans."Global Dimension 2 Code":=dim2;
                                        //objEmpTrans."Shortcut Dimension 3 Code":=dim3;
                                        //objEmpTrans."Shortcut Dimension 4 Code":=dim4;
                                        // objEmpTrans."Start Date" := objEmpTransPCA."Start Date";
                                        //objEmpTrans."End Date" := objEmpTransPCA."End Date";
                                        objEmpTrans.MODIFY;
                                        MESSAGE('objEmpTrans Modified: ' + Format(objEmpTrans."Employee Code"));
                                    END ELSE BEGIN
                                        objEmpTrans.INIT;
                                        objEmpTrans."Employee Code" := objEmpTransPCA."Employee Code";
                                        objEmpTrans."Transaction Code" := objEmpTransPCA."Transaction Code";
                                        objEmpTrans."Period Month" := intMonth;
                                        objEmpTrans."Period Year" := intYear;
                                        objEmpTrans."Payroll Period" := dtPAyrollPeriod;
                                        objEmpTrans."Transaction Name" := objEmpTransPCA."Transaction Name";
                                        objEmpTrans.Amount := objEmpTransPCA.Amount;
                                        objEmpTrans.Balance := objEmpTransPCA.Balance;
                                        objEmpTrans."Payroll Period" := objEmpTransPCA."Payroll Period";
                                        objEmpTrans."Payroll Code" := mPayrollCode;
                                        objEmpTrans."Department Code" := dim2;
                                        //objEmpTrans."Global Dimension 2 Code":=dim2;
                                        //objEmpTrans."Shortcut Dimension 3 Code":=dim3;
                                        //objEmpTrans."Shortcut Dimension 4 Code":=dim4;
                                        //objEmpTrans."Start Date" := objEmpTransPCA."Start Date";
                                        //objEmpTrans."End Date" := objEmpTransPCA."End Date";
                                        objEmpTrans.INSERT;
                                        MESSAGE('objEmpTrans Inserted: ' + Format(objEmpTrans."Transaction Code"));
                                    END;
                                END;
                                UNTIL objEmpTransPCA.NEXT = 0;
                            END;

                            Rec.Effected := TRUE;
                            Rec.Status := Rec.Status::Posted;
                            Rec.MODIFY;
                            if (Rec.MODIFY) then begin
                                MESSAGE('The changes has been uploaded to the current payroll');
                            end;



                        END;

                    end;
                }
            }
        }
    }

    trigger OnDeleteRecord(): Boolean
    begin
        //IF Rec.Status <> Rec.Status::Open THEN ERROR('You cannot modify a PCA if status is not open');
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        objPeriod.RESET;
        objPeriod.SETRANGE(objPeriod.Closed, FALSE);
        IF objPeriod.FIND('-') THEN BEGIN
            Rec."Payroll Period" := objPeriod."Date Opened";
            //:=objPeriod."Period Name";
            Rec."Period Month" := objPeriod."Period Month";
            Rec."Period Year" := objPeriod."Period Year";
        END;
    end;

    trigger OnModifyRecord(): Boolean
    begin
        IF Rec.Status <> Rec.Status::Approved THEN ERROR('You cannot modify a PCA if status is not open');
    end;

    var
        objPeriod: Record "PRL-Payroll Periods";
        uSetup: Record 91;
        mPayrollCode: Code[50];
        // objEmp: Record "HRM-Employee C";
        objEmp: Record "HRM-Employee C";
        objSalCard: Record "PRL-Salary Card";
        objEmpTrans: Record "PRL-Period Transactions";
        objEmpTransPCA: Record "prEmployee Trans PCA";
        objPayrollPeriod: Record "PRL-Payroll Periods";
        intMonth: Integer;
        intYear: Integer;
        dtPAyrollPeriod: Date;
        dim1: Code[50];
        dim2: Code[50];
        dim3: Code[50];
        dim4: Code[50];
        UserSetup: Record 91;
        CustomApprovals: Codeunit "Work Flow Code";
        VarVariant: Variant;
        ApprovalsMgmt: Codeunit 1535;

    procedure fnTrackChanges(columnss: Code[250]; oldValue: Code[250]; NewValue: Code[250])
    var
    //  HRtracker: Record "70135132";
    begin
        // HRtracker.INIT;
        // HRtracker."employee No" := "Employee Code";
        // HRtracker."Change Date" := TODAY;
        // HRtracker."Change Description" := columnss;
        // HRtracker."Old Value" := oldValue;
        // HRtracker."New Value" := NewValue;
        // HRtracker.UserID := USERID;
        // HRtracker.INSERT;
    end;
}

