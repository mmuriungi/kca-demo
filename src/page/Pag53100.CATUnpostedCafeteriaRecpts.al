page 53100 "CAT-Unposted Cafeteria Recpts"
{
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    ModifyAllowed = true;
    PageType = List;
    SourceTable = "CAT-Cafeteria Receipts";
    SourceTableView = WHERE(Status = FILTER(Printed));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Select; Rec.Select)
                {
                }
                field("Receipt No."; Rec."Receipt No.")
                {
                    Editable = false;
                }
                field("Receipt Date"; Rec."Receipt Date")
                {
                    Editable = false;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    Editable = false;
                }
                field("Campus Code"; Rec."Campus Code")
                {
                    Editable = false;
                }
                field(Department; Rec.Department)
                {
                    Editable = false;
                }
                field("Recept Total"; Rec."Recept Total")
                {
                    Editable = false;
                }
                field("Cancel Reason"; Rec."Cancel Reason")
                {
                    Editable = true;
                }
                field(User; Rec.User)
                {
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                }
                field("Cafeteria Section"; Rec."Cafeteria Section")
                {
                    Editable = false;
                }
                field("Employee No"; Rec."Employee No")
                {
                    Editable = false;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            group(Selection)
            {
                Caption = 'Selection';
                action(SelectAll)
                {
                    Caption = 'Select All';
                    Image = SelectLineToApply;
                    Promoted = true;

                    trigger OnAction()
                    begin

                        Receipts.RESET;
                        Receipts.COPYFILTERS(Rec);
                        Receipts.SETRANGE(Receipts.Status, Receipts.Status::Printed);

                        IF CONFIRM('Select All?', TRUE) = TRUE THEN BEGIN
                            IF Receipts.FIND('-') THEN BEGIN
                                REPEAT
                                BEGIN
                                    Receipts.Select := TRUE;
                                    Receipts.MODIFY;
                                END;
                                UNTIL Receipts.NEXT = 0;
                            END;
                        END;
                        CurrPage.UPDATE;
                    end;
                }
                action(UnselectAll)
                {
                    Caption = 'Unsellect All';
                    Image = CalculateShipment;
                    Promoted = true;

                    trigger OnAction()
                    begin


                        Receipts.RESET;
                        Receipts.COPYFILTERS(Rec);
                        Receipts.SETRANGE(Receipts.Status, Receipts.Status::Printed);
                        IF CONFIRM('UnSelect All?', TRUE) = TRUE THEN BEGIN
                            IF Receipts.FIND('-') THEN BEGIN
                                REPEAT
                                BEGIN
                                    Receipts.Select := FALSE;
                                    Receipts.MODIFY;
                                END;
                                UNTIL Receipts.NEXT = 0;
                            END;
                        END;
                        CurrPage.UPDATE;
                    end;
                }
            }
            group(Functions)
            {
                Caption = 'Functions';
                action(Post_Selected)
                {
                    Caption = 'Post Selected';
                    Image = Post;
                    Promoted = true;

                    trigger OnAction()
                    begin
                        // Get The Last GL Entry
                        //IF PeriodPostingto=0D THEN ERROR('Please select The Month in which the Credit Receipts will be Posted');
                        IF CONFIRM('Post this this Receipts?', FALSE) = FALSE THEN EXIT;

                        Receipts.RESET;
                        Receipts.COPYFILTERS(Rec);
                        Receipts.SETRANGE(Receipts.Status, Receipts.Status::Printed);
                        Receipts.SETRANGE(Receipts.Select, TRUE);

                        IF Receipts.FIND('-') THEN BEGIN
                            REPEAT
                            BEGIN
                                IF Receipts."Transaction Type" = Receipts."Transaction Type"::CREDIT THEN
                                    IF Receipts."Employee No" = '' THEN
                                        ERROR('Credit Receipts can''t be Posted without EMPLOYEE Numbers. Please uncheck such Receipts.');
                            END;
                            UNTIL Receipts.NEXT = 0;
                        END;

                        IF Receipts.FIND('-') THEN BEGIN
                        END
                        ELSE BEGIN
                            ERROR('Select Receipts to Post.')
                        END;

                        IF "GL Entry".FIND('-') THEN BEGIN
                            IF "GL Entry".FINDLAST() THEN BEGIN
                                "Last Entry" := "GL Entry"."Entry No."
                            END
                        END;
                        // Populate The Journal and post
                        Post();
                        // Check If Posted
                        /*IF "GL Entry".FIND('-') THEN
                          BEGIN
                          IF "GL Entry".FINDLAST() THEN
                            BEGIN
                              IF "GL Entry"."Entry No." <> "Last Entry" THEN
                                 BEGIN
                                   Approve(Receipts);
                                 END;
                            END
                          END;   */

                    end;
                }
                action(Cancel_Selected)
                {
                    Caption = 'Cancel Selected';
                    Image = CancelLine;
                    Promoted = true;

                    trigger OnAction()
                    begin

                        Receipts.RESET;
                        Receipts.COPYFILTERS(Rec);
                        Receipts.SETRANGE(Receipts.Status, Receipts.Status::Printed);
                        Receipts.SETRANGE(Receipts.Select, TRUE);

                        IF NOT Receipts.FIND('-') THEN
                            ERROR('No lines Selected!');

                        IF CONFIRM('Cancel Selected?', TRUE) = TRUE THEN BEGIN
                            IF Receipts.FIND('-') THEN BEGIN
                                REPEAT
                                BEGIN
                                    IF Receipts."Cancel Reason" = '' THEN ERROR('Provide the Cancel Reason for all Cancelled Receipts.');
                                    Receipts.Status := Receipts.Status::Canceled;
                                    Receipts.MODIFY;
                                    receiptLines.RESET;
                                    receiptLines.SETRANGE(receiptLines."Receipt No.", Receipts."Receipt No.");
                                    IF receiptLines.FIND('-') THEN BEGIN
                                        REPEAT
                                        BEGIN
                                            mealJournEntries.RESET;
                                            mealJournEntries.SETRANGE(mealJournEntries."Meal Code", receiptLines."Meal Code");
                                            mealJournEntries.SETRANGE(mealJournEntries."Receipt No.", Receipts."Receipt No.");
                                            IF mealJournEntries.FIND('-') THEN BEGIN
                                                mealJournEntries.DELETE;
                                            END;
                                            //  mealJournEntries.Template:='CAFE_INVENTORY';
                                            //  mealJournEntries.Batch:='ADJUSTMENT';
                                            //  mealJournEntries."Meal Code":=receiptLines."Meal Code";
                                            //  mealJournEntries."Posting Date":=receiptLines.Date;
                                            //  mealJournEntries."Line No.":=receiptLines."Line No.";
                                            //  mealJournEntries."Cafeteria Section":=receiptLines."Cafeteria Section";
                                            //  mealJournEntries."Transaction Type":=mealJournEntries."Transaction Type"::"Positive Adjustment";
                                            //  mealJournEntries.Quantity:=receiptLines.Quantity;
                                            //  mealJournEntries."User Id":=receiptLines.User;
                                            //  mealJournEntries."Unit Price":=receiptLines."Unit Price";
                                            //  mealJournEntries."Line Amount":=receiptLines."Total Amount";
                                            //  mealJournEntries."Meal Description":=receiptLines."Meal Descption";
                                            //  mealJournEntries.Source:=mealJournEntries.Source::Cancellation;
                                            //mealJournEntries.INSERT;
                                        END;
                                        UNTIL receiptLines.NEXT = 0;
                                    END;
                                END;
                                UNTIL Receipts.NEXT = 0;
                            END;
                        END;
                        CurrPage.UPDATE;
                    end;
                }
            }
        }
    }

    var
        mealJournEntries: Record "CAT-Cafe_Meal Ledger Entries";
        receiptLines: Record "CAT-Cafeteria Receipts Line";
        studrecords: Record "Customer";
        recounts: Integer;
        StudBal: Decimal;
        studcafeentries: Record "CAT-Std Cafe. Ledger Entry";
        cafestudLedgers: Record "CAT-Det. Students Cafe Ledgers";
        Receipts: Record "CAT-Cafeteria Receipts";
        Customer: Record "Customer";
        CustLedger: Record "Detailed Cust. Ledg. Entry";
        Bal: Decimal;
        GenLine: Record "Gen. Journal Line";
        GenSetUp: Record "General Ledger Setup";
        //SalesLine: Record "FIN-Cash Sale Line";
        "Line No": Integer;
        "GL Entry": Record "G/L Entry";
        "Last Entry": Integer;
        BankLedger: Record "Bank Account Ledger Entry";
        CashLine: Record "CAT-Cafeteria Receipts Line";
        Amt: Decimal;
        ReceiptRec: Record "CAT-Cafeteria Receipts";
        Revenue: Record "CAT-Cafe` Revenue Collections";
        lines: Integer;
        // premployeeTrans: Record "61091";
        prPayPeriod: Record "PRL-Payroll Periods";
        // PeriodPostingto: Date;
        genledgeSetup: Record "General Ledger Setup";
        cafesalesacc: Code[20];

    procedure Post()
    begin

        // Validate Fields
        genledgeSetup.RESET;
        IF genledgeSetup.FIND('-') THEN BEGIN
            // Find the Cafe Sales Account
        END;

        Rec.TESTFIELD("Receipt No.");
        // TESTFIELD("Customer Name");
        Rec.TESTFIELD("Receipt Date");
        Rec.TESTFIELD(Department);
        Rec.TESTFIELD("Cashier Bank");
        /*IF "Cashier Bank"="Paying Bank Account" THEN
        BEGIN
          ERROR('Customer Bank Account No. Can Not be The Same As Receiving Bank Account No.')
        END; */
        Receipts.RESET;
        Receipts.COPYFILTERS(Rec);
        Receipts.SETRANGE(Receipts.Status, Receipts.Status::Printed);
        Receipts.SETRANGE(Receipts.Select, TRUE);
        IF Receipts.FIND('-') THEN BEGIN
        END
        ELSE BEGIN
            ERROR('Select Receipts to Post.')
        END;

        GenSetUp.GET();

        GenLine.SETRANGE(GenLine."Journal Template Name", GenSetUp."Cash Template");
        GenLine.SETRANGE(GenLine."Journal Batch Name", GenSetUp."Cash Batch");

        // Clear The Batch
        IF GenLine.FIND('-') THEN BEGIN
            REPEAT
                GenLine.DELETE;
            UNTIL GenLine.NEXT = 0;
        END;
        // Populate The Journal
        "Line No" := 100000;
        Receipts.RESET;
        Receipts.COPYFILTERS(Rec);
        Receipts.SETRANGE(Receipts.Status, Receipts.Status::Printed);
        Receipts.SETRANGE(Receipts.Select, TRUE);
        IF Receipts.FIND('-') THEN BEGIN
            REPEAT
                receiptLines.RESET;
                receiptLines.SETRANGE(receiptLines."Receipt No.", Receipts."Receipt No.");
                IF receiptLines.FIND('-') THEN BEGIN
                    REPEAT
                    BEGIN
                        /*mealJournEntries.INIT;
                          mealJournEntries.Template:='CAFE_INVENTORY';
                          mealJournEntries.Batch:='ADJUSTMENT';
                          mealJournEntries."Meal Code":=receiptLines."Meal Code";
                          mealJournEntries."Posting Date":=receiptLines.Date;
                          mealJournEntries."Line No.":=receiptLines."Line No.";
                          mealJournEntries."Cafeteria Section":=receiptLines."Cafeteria Section";
                          mealJournEntries."Transaction Type":=mealJournEntries."Transaction Type"::"Positive Adjustment";
                          mealJournEntries.Quantity:=receiptLines.Quantity*(-1);
                          mealJournEntries."User Id":=receiptLines.User;
                          mealJournEntries."Unit Price":=receiptLines."Unit Price";
                          mealJournEntries."Line Amount":=receiptLines."Total Amount";
                          mealJournEntries."Meal Description":=receiptLines."Meal Descption";
                          mealJournEntries.Source:=mealJournEntries.Source::Sales;
                        mealJournEntries.INSERT; */
                    END;
                    UNTIL receiptLines.NEXT = 0;
                END;

                // if this Receipt was on credit, then fetch the employee then
                //Add him this on then transactions or create one for the same.

                /* IF Receipts."Transaction Type"=Receipts."Transaction Type"::CREDIT THEN
                    IF Receipts."Employee No"<>'' THEN BEGIN
                  prPayPeriod.RESET;
                  prPayPeriod.SETRANGE(prPayPeriod."Date Opened",PeriodPostingto);
                  IF prPayPeriod.FIND('-') THEN
                    BEGIN
                      premployeeTrans.RESET;
                      premployeeTrans.SETRANGE(premployeeTrans."Employee Code",Receipts."Employee No");
                      premployeeTrans.SETRANGE(premployeeTrans."Period Month",prPayPeriod."Period Month");
                      premployeeTrans.SETRANGE(premployeeTrans."Period Year",prPayPeriod."Period Year");
                      premployeeTrans.SETRANGE(premployeeTrans."Transaction Code",'120');
                      IF premployeeTrans.FIND('-') THEN
                        BEGIN
                        Receipts.CALCFIELDS(Receipts."Recept Total");
                         premployeeTrans.Amount:=premployeeTrans.Amount+Receipts."Recept Total";
                         premployeeTrans.MODIFY;
                        END ELSE BEGIN // insert the Cafeteria Transaction into the payroll for the Employee
                        premployeeTrans.INIT;
                        premployeeTrans."Employee Code":=Receipts."Employee No";
                        premployeeTrans."Transaction Code":='120';
                        premployeeTrans."Period Month":=prPayPeriod."Period Month";
                        premployeeTrans."Period Year":=prPayPeriod."Period Year";
                        premployeeTrans."Payroll Period":=prPayPeriod."Date Opened";
                        premployeeTrans."Transaction Name":='CAFETERIA';
                        Receipts.CALCFIELDS(Receipts."Recept Total");
                        premployeeTrans.Amount:=Receipts."Recept Total";
                        premployeeTrans.INSERT();
                        END;
                    END;
                    END; */

                IF Receipts."Transaction Type" <> Receipts."Transaction Type"::"ADVANCE PAYMENT" THEN BEGIN

                    Revenue.RESET;
                    Revenue.SETRANGE(Revenue."Posting Date", Receipts."Receipt Date");
                    // Revenue.SETRANGE(Revenue."MAN CASH",Receipts.Sections);

                    Receipts.CALCFIELDS(Receipts."Recept Total");
                    IF Revenue.FIND('-') THEN BEGIN
                        IF Receipts.Sections = 'Students' THEN BEGIN
                            IF Receipts."Transaction Type" = Receipts."Transaction Type"::CASH THEN
                                Revenue."CAFE CASH" := Revenue."CAFE CASH" + Receipts."Recept Total"
                            ELSE
                                IF Receipts."Transaction Type" = Receipts."Transaction Type"::CREDIT THEN
                                    Revenue."CAFE CREDIT" := Revenue."CAFE CREDIT" + Receipts."Recept Total"
                                ELSE
                                    IF Receipts."Transaction Type" = Receipts."Transaction Type"::"ADVANCE PAYMENT" THEN
                                        Revenue."CAFE ADVANCE" := Revenue."CAFE ADVANCE" + Receipts."Recept Total";
                            Revenue."CAFE TOTAL" := Revenue."CAFE TOTAL" + Receipts."Recept Total";
                            Revenue."GRAND TOTAL" := Revenue."GRAND TOTAL" + Receipts."Recept Total";
                            Revenue.MODIFY
                        END ELSE
                            IF Receipts.Sections = 'Staff' THEN BEGIN
                                IF Receipts."Transaction Type" = Receipts."Transaction Type"::CASH THEN
                                    Revenue."MAN CASH" := Revenue."MAN CASH" + Receipts."Recept Total"
                                ELSE
                                    IF Receipts."Transaction Type" = Receipts."Transaction Type"::CREDIT THEN
                                        Revenue."MAN CREDIT" := Revenue."MAN CREDIT" + Receipts."Recept Total"
                                    ELSE
                                        IF Receipts."Transaction Type" = Receipts."Transaction Type"::"ADVANCE PAYMENT" THEN
                                            Revenue."MAN ADVANCE" := Revenue."MAN ADVANCE" + Receipts."Recept Total";
                                Revenue."MAN TOTAL" := Revenue."MAN TOTAL" + Receipts."Recept Total";
                                Revenue."GRAND TOTAL" := Revenue."GRAND TOTAL" + Receipts."Recept Total";
                                Revenue.MODIFY
                            END;
                    END ELSE BEGIN
                        IF Receipts.Sections = 'Students' THEN BEGIN
                            IF Receipts."Transaction Type" <> Receipts."Transaction Type"::"ADVANCE PAYMENT" THEN BEGIN
                                Revenue.RESET;
                                IF Revenue.FIND('-') THEN BEGIN
                                    IF Revenue.COUNT = 0 THEN lines := 0 ELSE lines := Revenue.COUNT;
                                END ELSE
                                    lines := 0;
                                Revenue.INIT();
                                lines := Revenue.COUNT + 1;
                                Revenue.Counts := lines;
                                Revenue."Posted By" := USERID;
                                Revenue."Posting Date" := Receipts."Receipt Date";//Receipts."Posted Date";
                                IF Receipts."Transaction Type" = Receipts."Transaction Type"::CASH THEN
                                    Revenue."CAFE CASH" := Receipts."Recept Total"
                                ELSE
                                    IF Receipts."Transaction Type" = Receipts."Transaction Type"::CREDIT THEN
                                        Revenue."CAFE CREDIT" := Receipts."Recept Total"
                                    ELSE
                                        IF Receipts."Transaction Type" = Receipts."Transaction Type"::"ADVANCE PAYMENT" THEN
                                            Revenue."CAFE ADVANCE" := Receipts."Recept Total";
                                Revenue."CAFE TOTAL" := Receipts."Recept Total";
                                Revenue."GRAND TOTAL" := Receipts."Recept Total";
                                Revenue.INSERT(TRUE);
                            END;
                        END ELSE
                            IF Receipts.Sections = 'Staff' THEN BEGIN
                                IF Receipts."Transaction Type" <> Receipts."Transaction Type"::"ADVANCE PAYMENT" THEN BEGIN
                                    Revenue.RESET;
                                    IF Revenue.FIND('-') THEN BEGIN
                                        IF Revenue.COUNT = 0 THEN lines := 0 ELSE lines := Revenue.COUNT;
                                    END ELSE
                                        lines := 0;
                                    lines := Revenue.COUNT + 1;
                                    Revenue.INIT();
                                    Revenue.Counts := lines;
                                    Revenue."Posted By" := USERID;
                                    Revenue."Posting Date" := Receipts."Receipt Date";//Receipts."Posted Date";
                                    IF Receipts."Transaction Type" = Receipts."Transaction Type"::CASH THEN
                                        Revenue."MAN CASH" := Receipts."Recept Total"
                                    ELSE
                                        IF Receipts."Transaction Type" = Receipts."Transaction Type"::CREDIT THEN
                                            Revenue."MAN CREDIT" := Receipts."Recept Total"
                                        ELSE
                                            IF Receipts."Transaction Type" = Receipts."Transaction Type"::"ADVANCE PAYMENT" THEN
                                                Revenue."MAN ADVANCE" := Receipts."Recept Total";
                                    Revenue."MAN TOTAL" := Receipts."Recept Total";
                                    Revenue."GRAND TOTAL" := Receipts."Recept Total";
                                    Revenue.INSERT(TRUE);
                                END;
                            END;

                    END; // ELSE IF Receipts."Transaction Type"=Receipts."Transaction Type"::"ADVANCE PAYMENT" THEN

                END;
                IF Receipts."Transaction Type" <> Receipts."Transaction Type"::"ADVANCE PAYMENT" THEN BEGIN
                    "Line No" := "Line No" + 1000000;
                    GenLine.INIT();
                    GenLine."Posting Date" := TODAY;//Receipts."Posted Date";
                    GenLine."Document No." := Receipts."Receipt No.";
                    GenLine."Transaction Type" := GenLine."Transaction Type"::Cafeteria;
                    Receipts.CALCFIELDS(Receipts."Recept Total");
                END;
                // IF "Transaction Type" = Receipts."Transaction Type"::CASH THEN
                //  ELSE GenLine."Account No.":='61027';
                IF Rec."Transaction Type" = Receipts."Transaction Type"::CASH THEN BEGIN
                    Receipts.CALCFIELDS(Receipts."Recept Total");
                    GenLine.Description := 'Cafeteria Cash Receipts';
                    GenLine."Journal Template Name" := GenSetUp."Cash Template";
                    GenLine."Journal Batch Name" := GenSetUp."Cash Batch";
                    GenLine."Source Code" := 'CAFECASH';
                    GenLine."Account Type" := GenLine."Account Type"::"G/L Account";
                    GenLine."Account No." := genledgeSetup."Cafeteria Sales Account";
                    // Receipts.CALCFIELDS(Receipts."Recept Total");
                    // GenLine."Credit Amount":=Receipts."Recept Total";
                    GenLine."Bal. Account Type" := GenLine."Bal. Account Type"::"Bank Account";
                    GenLine."Bal. Account No." := Receipts."Cashier Bank";
                    // GenLine.VALIDATE(GenLine."Credit Amount");
                    GenLine."Line No." := "Line No";
                    GenLine."Shortcut Dimension 1 Code" := Rec."Campus Code";
                    GenLine."Shortcut Dimension 2 Code" := Rec.Department;
                    GenLine.VALIDATE(GenLine."Shortcut Dimension 1 Code");
                    GenLine.VALIDATE(GenLine."Shortcut Dimension 2 Code");
                    GenLine.Amount := -Receipts."Recept Total";
                    GenLine.VALIDATE(GenLine.Amount);

                END ELSE
                    IF Rec."Transaction Type" = Receipts."Transaction Type"::CREDIT THEN BEGIN
                        Receipts.CALCFIELDS(Receipts."Recept Total");
                        GenLine.Description := 'Cafeteria Credit Sales';
                        GenLine."Journal Template Name" := GenSetUp."Cash Template";
                        GenLine."Journal Batch Name" := GenSetUp."Cash Batch";
                        GenLine."Source Code" := 'CAFECREDIT';
                        GenLine."Account Type" := GenLine."Account Type"::"G/L Account";
                        GenLine."Account No." := genledgeSetup."Cafeteria Credit Sales Account";
                        GenLine."Bal. Account Type" := GenLine."Bal. Account Type"::Customer;
                        GenLine."Bal. Account No." := Receipts."Employee No";
                        GenLine.VALIDATE(GenLine."Bal. Account No.");
                        GenLine."Line No." := "Line No";
                        GenLine."Shortcut Dimension 1 Code" := Rec."Campus Code";
                        GenLine."Shortcut Dimension 2 Code" := Rec.Department;
                        GenLine.VALIDATE(GenLine."Shortcut Dimension 1 Code");
                        GenLine.VALIDATE(GenLine."Shortcut Dimension 2 Code");
                        GenLine.Amount := -Receipts."Recept Total";
                        GenLine.VALIDATE(GenLine.Amount);
                    END ELSE
                        IF Rec."Transaction Type" = Receipts."Transaction Type"::"ADVANCE PAYMENT" THEN BEGIN
                            Receipts.CALCFIELDS(Receipts."Recept Total");
                            PostStudentCafeReceipts(Receipts."Employee No", Receipts."Receipt No.", Receipts."Recept Total");
                            //    GenLine."Journal Template Name":=GenSetUp."Cash Template";
                            //    GenLine."Journal Batch Name":=GenSetUp."Cash Batch";
                            //   GenLine."Source Code":='ADVANCASH';
                            // GenLine."Account Type":=GenLine."Account Type"::"G/L Account";
                            //  GenLine."Account No.":='10119';//genledgeSetup."Cafeteria Advance Account";
                            //   GenLine.Description:='Cafeteria ADVANCE PAYMENT Sales';
                            //   GenLine."Bal. Account Type":=GenLine."Bal. Account Type"::Vendor;
                            //   GenLine."Bal. Account No.":="Employee No";
                            //   GenLine.VALIDATE(GenLine."Bal. Account No.");
                            //   GenLine."Line No.":="Line No";
                            //   GenLine."Shortcut Dimension 1 Code":="Campus Code";
                            //   GenLine."Shortcut Dimension 2 Code":=Department;
                            //   GenLine.VALIDATE(GenLine."Shortcut Dimension 1 Code");
                            //   GenLine.VALIDATE(GenLine."Shortcut Dimension 2 Code");
                            //   GenLine.Amount:=Receipts."Recept Total";
                            //   GenLine.VALIDATE(GenLine.Amount);
                            //ERROR('Amount is '+Receipts."Employee No"+', '+Receipts."Receipt No."+', '+FORMAT(Receipts."Recept Total"));
                        END;
                IF Receipts."Transaction Type" <> Receipts."Transaction Type"::"ADVANCE PAYMENT" THEN BEGIN

                    GenLine.INSERT(TRUE);
                END;
                Approve(Receipts);
            UNTIL Receipts.NEXT = 0;
        END;
        IF Receipts."Transaction Type" <> Receipts."Transaction Type"::"ADVANCE PAYMENT" THEN BEGIN


            GenLine.RESET;
            GenSetUp.GET();
            GenLine.SETRANGE(GenLine."Journal Template Name", GenSetUp."Cash Template");
            GenLine.SETRANGE(GenLine."Journal Batch Name", GenSetUp."Cash Batch");
            CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post", GenLine);
        END;



        ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /*
        // Validate Fields
        
          TESTFIELD("Receipt No.");
         // TESTFIELD("Customer Name");
          TESTFIELD("Receipt Date");
          TESTFIELD(Department);
          TESTFIELD("Cashier Bank");
          {IF "Cashier Bank"="Paying Bank Account" THEN
          BEGIN
            ERROR('Customer Bank Account No. Can Not be The Same As Receiving Bank Account No.')
          END; }
            Receipts.RESET;
            Receipts.COPYFILTERS(Rec);
            Receipts.SETRANGE(Receipts.Status,Receipts.Status::Printed);
            Receipts.SETRANGE(Receipts.Select,TRUE);
            IF Receipts.FIND('-') THEN
              BEGIN
              END
            ELSE BEGIN
              ERROR('Select Receipts to Post.')
            END;
        
           GenSetUp.GET();
        
           GenLine.SETRANGE(GenLine."Journal Template Name",GenSetUp."Cash Template");
           GenLine.SETRANGE(GenLine."Journal Batch Name",GenSetUp."Cash Batch") ;
        
          // Clear The Batch
            IF GenLine.FIND('-') THEN
             BEGIN
               REPEAT
                 GenLine.DELETE;
                 UNTIL GenLine.NEXT=0;
             END;
         // Populate The Journal
            "Line No":=100000;
              Receipts.RESET;
              Receipts.COPYFILTERS(Rec);
              Receipts.SETRANGE(Receipts.Status,Receipts.Status::Printed);
              Receipts.SETRANGE(Receipts.Select,TRUE);
               IF Receipts.FIND('-') THEN
               BEGIN
               REPEAT
        
        // if this Receipt was on credit, then fetch the employee then
        //Add him this on then transactions or create one for the same.
        
        { IF Receipts."Transaction Type"=Receipts."Transaction Type"::CREDIT THEN
            IF Receipts."Employee No"<>'' THEN BEGIN
          prPayPeriod.RESET;
          prPayPeriod.SETRANGE(prPayPeriod."Date Opened",PeriodPostingto);
          IF prPayPeriod.FIND('-') THEN
            BEGIN
              premployeeTrans.RESET;
              premployeeTrans.SETRANGE(premployeeTrans."Employee Code",Receipts."Employee No");
              premployeeTrans.SETRANGE(premployeeTrans."Period Month",prPayPeriod."Period Month");
              premployeeTrans.SETRANGE(premployeeTrans."Period Year",prPayPeriod."Period Year");
              premployeeTrans.SETRANGE(premployeeTrans."Transaction Code",'120');
              IF premployeeTrans.FIND('-') THEN
                BEGIN
                Receipts.CALCFIELDS(Receipts."Recept Total");
                 premployeeTrans.Amount:=premployeeTrans.Amount+Receipts."Recept Total";
                 premployeeTrans.MODIFY;
                END ELSE BEGIN // insert the Cafeteria Transaction into the payroll for the Employee
                premployeeTrans.INIT;
                premployeeTrans."Employee Code":=Receipts."Employee No";
                premployeeTrans."Transaction Code":='120';
                premployeeTrans."Period Month":=prPayPeriod."Period Month";
                premployeeTrans."Period Year":=prPayPeriod."Period Year";
                premployeeTrans."Payroll Period":=prPayPeriod."Date Opened";
                premployeeTrans."Transaction Name":='CAFETERIA';
                Receipts.CALCFIELDS(Receipts."Recept Total");
                premployeeTrans.Amount:=Receipts."Recept Total";
                premployeeTrans.INSERT();
                END;
            END;
            END; }
        
        
        IF Receipts."Transaction Type"=Receipts."Transaction Type"::"ADVANCE PAYMENT" THEN BEGIN
        WITH Revenue DO
          BEGIN
          Revenue.RESET;
          Revenue.SETRANGE(Revenue."Posting Date",Receipts."Receipt Date");
         // Revenue.SETRANGE(Revenue."MAN CASH",Receipts.Sections);
        
        Receipts.CALCFIELDS(Receipts."Recept Total");
        IF Revenue.FIND('-') THEN BEGIN
        IF Receipts.Sections='CAFETERIA' THEN BEGIN
            IF Receipts."Transaction Type"=Receipts."Transaction Type"::CASH THEN
            Revenue."CAFE CASH":=Revenue."CAFE CASH"+Receipts."Recept Total"
            ELSE Revenue."CAFE CREDIT":=Revenue."CAFE CREDIT"+Receipts."Recept Total";
            Revenue."CAFE TOTAL":=Revenue."CAFE TOTAL"+Receipts."Recept Total";
            Revenue."GRAND TOTAL":=Revenue."GRAND TOTAL"+Receipts."Recept Total";
            Revenue.MODIFY
         END ELSE IF Receipts.Sections='MANAGEMENT' THEN  BEGIN
            IF Receipts."Transaction Type"=Receipts."Transaction Type"::CASH THEN
            Revenue."MAN CASH":=Revenue."MAN CASH"+Receipts."Recept Total"
            ELSE Revenue."MAN CREDIT":=Revenue."MAN CREDIT"+Receipts."Recept Total";
            Revenue."MAN TOTAL":=Revenue."MAN TOTAL"+Receipts."Recept Total";
            Revenue."GRAND TOTAL":=Revenue."GRAND TOTAL"+Receipts."Recept Total";
            Revenue.MODIFY
         END;
        END ELSE BEGIN
        IF Receipts.Sections='CAFETERIA' THEN BEGIN
            Revenue.RESET;
            IF Revenue.FIND('-') THEN BEGIN
             IF Revenue.COUNT = 0 THEN lines:=0 ELSE lines:=Revenue.COUNT; END ELSE lines:=0;
            Revenue.INIT();
            lines:=Revenue.COUNT+1;
            Revenue.Counts:=lines;
            Revenue."Posted By":=USERID;
            Revenue."Posting Date":=Receipts."Receipt Date";
            IF Receipts."Transaction Type"=Receipts."Transaction Type"::CASH THEN
            Revenue."CAFE CASH":=Receipts."Recept Total" ELSE Revenue."CAFE CREDIT":=Receipts."Recept Total";
            Revenue."CAFE TOTAL":=Receipts."Recept Total";
            Revenue."GRAND TOTAL":=Receipts."Recept Total";
            Revenue.INSERT(TRUE);
         END ELSE IF Receipts.Sections='MANAGEMENT' THEN  BEGIN
            Revenue.RESET;
            IF Revenue.FIND('-') THEN BEGIN
             IF Revenue.COUNT = 0 THEN lines:=0 ELSE lines:=Revenue.COUNT; END ELSE lines:=0;
            lines:=Revenue.COUNT+1;
            Revenue.INIT();
            Revenue.Counts:=lines;
            Revenue."Posted By":=USERID;
            Revenue."Posting Date":=Receipts."Receipt Date";
            IF Receipts."Transaction Type"=Receipts."Transaction Type"::CASH THEN
            Revenue."MAN CASH":=Receipts."Recept Total" ELSE Revenue."MAN CREDIT":=Receipts."Recept Total";
            Revenue."MAN TOTAL":=Receipts."Recept Total";
            Revenue."GRAND TOTAL":=Receipts."Recept Total";
            Revenue.INSERT(TRUE);
        END;
        
        END;
        end;// IF Receipts."Transaction Type"=Receipts."Transaction Type"::"ADVANCE PAYMENT" THEN
        
          END;
                   "Line No":="Line No"+1000000;
                   GenLine.INIT();
                   GenLine."Journal Template Name":=GenSetUp."Cash Template";
                   GenLine."Journal Batch Name":=GenSetUp."Cash Batch";
                   GenLine."Source Code":='CAFECREDIT';
                   GenLine."Posting Date":=Receipts."Receipt Date";
                   GenLine."Document No.":=Receipts."Receipt No.";
                   GenLine."Transaction Type":=GenLine."Transaction Type"::Cafeteria;
                   Receipts.CALCFIELDS(Receipts."Recept Total");
                   GenLine.Amount:=-Receipts."Recept Total";
                   GenLine.VALIDATE(GenLine.Amount);
                   GenLine."Account Type":=GenLine."Account Type"::"G/L Account";
                  // IF "Transaction Type" = Receipts."Transaction Type"::CASH THEN
                   GenLine."Account No.":='10119';
                  //  ELSE GenLine."Account No.":='61027';
                   IF Receipts."Transaction Type" = Receipts."Transaction Type"::CASH THEN BEGIN
                   GenLine.Description:='Cafeteria Cash Receipts';
                  // Receipts.CALCFIELDS(Receipts."Recept Total");
                  // GenLine."Credit Amount":=Receipts."Recept Total";
                   GenLine."Bal. Account Type":=GenLine."Bal. Account Type"::"Bank Account";
                   GenLine."Bal. Account No.":=Receipts."Cashier Bank";
                  // GenLine.VALIDATE(GenLine."Credit Amount");
                   GenLine."Line No.":="Line No";
                   GenLine."Shortcut Dimension 1 Code":="Campus Code";
                   GenLine."Shortcut Dimension 2 Code":=Department;
                   GenLine.VALIDATE(GenLine."Shortcut Dimension 1 Code");
                   GenLine.VALIDATE(GenLine."Shortcut Dimension 2 Code");
        
                    END ELSE BEGIN
                   GenLine.Description:='Cafeteria Credit Sales';
                   GenLine."Bal. Account Type":=GenLine."Bal. Account Type"::Customer;
                   GenLine."Bal. Account No.":=Receipts."Employee No";
                   GenLine.VALIDATE(GenLine."Bal. Account No.");
                   GenLine."Line No.":="Line No";
                   GenLine."Shortcut Dimension 1 Code":="Campus Code";
                   GenLine."Shortcut Dimension 2 Code":=Department;
                   GenLine.VALIDATE(GenLine."Shortcut Dimension 1 Code");
                   GenLine.VALIDATE(GenLine."Shortcut Dimension 2 Code");
                    END;
                   GenLine.INSERT(TRUE);
                    Approve(Receipts);
                   UNTIL  Receipts.NEXT=0;
        END;  */

        MESSAGE('posted Successfully!');

    end;

    procedure Approve(Receipt: Record "CAT-Cafeteria Receipts")
    begin
        Receipt.Status := Rec.Status::Posted;
        // "Update Mini Cash"();
        // "Create Journal"();
        Receipt."Posted By" := USERID;
        Receipt."Posted Date" := TODAY;
        Receipt."Posted Time" := TIME;
        Receipt.MODIFY;
    end;

    procedure "Update Mini Cash"()
    begin
        /*IF BankLedger.FINDLAST() THEN
        BEGIN
         "Line No":=BankLedger."Entry No."+1
        END
        ELSE BEGIN
         "Line No":=1
        END;

        BankLedger.INIT;
        BankLedger."Entry No.":="Line No";
        BankLedger."Bank Account No.":="Paying Bank Account";
        BankLedger."Posting Date":=Date;
        BankLedger."Document No.":="Receipt No";
        BankLedger.Description:="Receipt No" + '/ Cash Settlement';
        BankLedger.Amount:=-Amount;
        BankLedger."Remaining Amount":=-Amount;
        BankLedger."Amount (LCY)":=-Amount;
        BankLedger."User ID":="Received By";
        BankLedger.Open:=TRUE;
        BankLedger."Document Date":=Date;
        BankLedger.INSERT(TRUE) ;
      */

    end;

    procedure "Create Journal"()
    begin
        /*
       GenLine.RESET;
       "Line No":=GenLine.COUNT+100000;
       GenLine.INIT;
       GenLine."Journal Template Name":='CASH RECEI';
       GenLine."Journal Batch Name":='CASH';
       GenLine."Posting Date":=Date;
       GenLine."Line No.":="Line No";
       GenLine."Document No.":="Doc No";
       GenLine."Document Type":=0;
       GenLine."External Document No.":="Cheque No";
       GenLine.Description:="Customer No"+' / '+"Cashier Bank";
       GenLine."Account Type":=GenLine."Account Type"::"Bank Account";
       GenLine."Account No.":="Receiving Bank A/C";
       GenLine.Amount:=Amt;
       GenLine."Bal. Account Type":=GenLine."Bal. Account Type"::"Bank Account";
       GenLine."Bal. Account No.":="Cashier Bank";
       GenLine.VALIDATE(GenLine.Amount);
       GenLine.INSERT(TRUE);
        */

        Receipts.RESET;
        Receipts.SETRANGE(Receipts.Status, Receipts.Status::Printed);
        Receipts.SETRANGE(Receipts.Select, TRUE);
        IF Receipts.FIND('-') THEN BEGIN
            REPEAT
                GenLine.RESET;
                "Line No" := GenLine.COUNT + 100;
                GenLine.INIT;
                GenLine."Journal Template Name" := 'CASH RECEI';
                GenLine."Journal Batch Name" := 'main2 cash';
                GenLine."Posting Date" := Receipts."Receipt Date";
                GenLine."Line No." := "Line No";
                GenLine."Document No." := Receipts."Receipt No.";
                GenLine."Document Type" := 0;
                GenLine."External Document No." := Receipts."Doc. No.";
                GenLine.Description := Rec."Customer Name" + ' - ' + Rec."Doc. No.";
                GenLine.Remarks := 'Cafeteria Sales';
                GenLine."Account Type" := GenLine."Account Type"::"Bank Account";
                GenLine."Account No." := '10201';
                Receipts.CALCFIELDS(Receipts."Recept Total");
                GenLine."Credit Amount" := Receipts."Recept Total";

                GenLine."Bal. Account Type" := GenLine."Bal. Account Type"::"Bank Account";
                GenLine."Bal. Account No." := Receipts."Cashier Bank";
                GenLine.VALIDATE(GenLine.Amount);
                GenLine.INSERT(TRUE);
            UNTIL Receipts.NEXT = 0;
        END;

    end;

    procedure PostStudentCafeReceipts(var studno: Code[20]; var ReceiptNo: Code[20]; var CafeAmount: Decimal)
    begin
        studrecords.RESET;
        studrecords.SETRANGE(studrecords."No.", studno);
        IF studrecords.FIND('-') THEN BEGIN
        END;

        CLEAR(StudBal);
        // studrecords.CALCFIELDS(studrecords."Balance (Cafe)");
        // StudBal:=studrecords."Balance (Cafe)";
        CLEAR(recounts);

        cafestudLedgers.RESET;
        cafestudLedgers.SETCURRENTKEY(cafestudLedgers."Entry No.");
        IF cafestudLedgers.FIND('+') THEN
            recounts := cafestudLedgers."Entry No." + 1
        ELSE
            recounts := 0;
        recounts := recounts + 1;

        StudBal := StudBal - CafeAmount;

        cafestudLedgers.INIT;
        cafestudLedgers."Entry No." := recounts;
        cafestudLedgers."Cust. Ledger Entry No." := recounts;
        cafestudLedgers."Posting Date" := TODAY;
        cafestudLedgers."Document No." := ReceiptNo;
        cafestudLedgers.Amount := (CafeAmount * -1);
        cafestudLedgers."Customer No." := studno;
        cafestudLedgers."User ID" := USERID;
        cafestudLedgers."Source Code" := 'CAFEADV';
        cafestudLedgers."Transaction No." := recounts;
        cafestudLedgers."Reason Code" := '221';
        cafestudLedgers."Credit Amount" := (CafeAmount);
        cafestudLedgers.Description := 'Student meals  [' + studno + '], Date: ' + FORMAT(TODAY);
        cafestudLedgers.Balance := StudBal;
        cafestudLedgers.INSERT;

        studcafeentries.INIT;
        studcafeentries."Entry No." := recounts;
        studcafeentries."Customer No." := studno;
        studcafeentries."Posting Date" := TODAY;
        studcafeentries."Document No." := ReceiptNo;
        studcafeentries.Description := 'Payment for Meals [' + studno + '], Date: ' + FORMAT(TODAY);
        ;
        studcafeentries."User ID" := USERID;
        studcafeentries."Source Code" := 'CAFEADV';
        studcafeentries.INSERT;
    end;
}

