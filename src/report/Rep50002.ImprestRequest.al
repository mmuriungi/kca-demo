report 50002 "Imprest Request"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Imprest Requisitions.rdl';

    dataset
    {
        dataitem("Payments Header"; "FIN-Imprest Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
            column(CompanyName; Company.Name)
            {
            }
            column(Cashier; Cashier) { }
            column(log; Company.Picture)
            {
            }
            column(Address; company.Address)
            {
            }
            column(Address2; company."Address 2")
            {
            }
            column(CompPhone; Company."Phone No.") { }
            column(Company_Email; Company."E-Mail") { }
            column(Company_Website; Company."Home Page") { }
            column(Payments_Header__No__; "Payments Header"."No.")
            {
            }
            column(Payments_Header_Payee; "Payments Header".Payee)
            {
            }
            column(Committed_Amount; "Committed Amount") { }
            column(Budget_Balance; "Budget Balance") { }
            column(Total_Net_Amount; "Total Net Amount") { }
            column(Payments_Header__Payments_Header__Date; "Payments Header".Date)
            {
            }
            column(Payments_Header__Global_Dimension_1_Code_; "Global Dimension 1 Code")
            {
            }
            column(Account_No; "Account No.")
            {
            }
            column(Payments_Header_Purpose; Purpose)
            {
            }
            column(DptName; DptName)
            {
            }
            column(USERID; USERID)
            {
            }
            column(NumberText_1_; NumberText[1])
            {
            }
            column(TTotal; TTotal)
            {
                DecimalPlaces = 2 : 2;
            }
            column(TIME_PRINTED_____FORMAT_TIME_; 'TIME PRINTED:' + FORMAT(TIME))
            {
                AutoFormatType = 1;
            }
            column(DATE_PRINTED_____FORMAT_TODAY_0_4_; 'DATE PRINTED:' + FORMAT(TODAY, 0, 4))
            {
                AutoFormatType = 1;
            }
            column(CurrCode; CurrCode)
            {
            }
            column(Projectname; Projectname)
            {

            }
            column(Payee; Payee)
            {

            }
            column(Cheque_No_; "Cheque No.") { }
            column(TotalNetAmount_PaymentsHeader; "Payments Header"."Total Net Amount")
            {
            }
            column(Purpose; "Payments Header".Purpose)
            {
            }
            dataitem("Payment Line"; "FIN-Imprest Lines")
            {
                DataItemLink = No = FIELD("No.");
                DataItemTableView = SORTING(No, "Account No:")
                                    ORDER(Ascending);
                column(Payment_Line_Amount; Amount)
                {
                }
                column(UserName; UserName) { }
                column(Account_No________Account_Name_; "Payment Line"."Account Name")
                {
                }
                column(Payment_Line_No; No)
                {
                }
                column(Approver1; Approver1) { }
                column(Approver2; Approver2) { }
                column(approver3; approver3) { }
                column(approver4; approver4) { }
                column(AppravalDate1; AppravalDate1) { }
                column(ApprovalDate2; ApprovalDate2) { }
                column(ApprovalDate3; ApprovalDate2) { }
                column(approvalDate4; approvalDate4) { }
                column(Purpose_Line; Purpose) { }
                column(Payment_Line_Account_No_; "Account No:")
                {
                }
                column(DimValName; DimValName) { }
                trigger OnAfterGetRecord()
                begin
                    DimVal.RESET;
                    DimVal.SETRANGE(DimVal."Global Dimension No.", 2);
                    DimVal.SETRANGE(DimVal.Code, "Shortcut Dimension 2 Code");
                    DimValName := '';
                    IF DimVal.FINDFIRST THEN BEGIN
                        DimValName := DimVal.Name;
                    END;

                    TTotal := TTotal + "Payment Line".Amount;
                    "Payments Header".CALCFIELDS("Payments Header"."Total Net Amount");
                    CheckReport.InitTextVariable();
                    CheckReport.FormatNoText(NumberText, "Payments Header"."Total Net Amount", '');
                end;
            }
            dataitem(ApprovalEntry; "Approval Entry")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = WHERE(Status = CONST(Approved));
                column(ApproverID_ApprovalEntry; ApprovalEntry."Approver ID")
                {
                }
                column(LastDateTimeModified_ApprovalEntry; format(ApprovalEntry."Last Date-Time Modified"))
                {
                }

                dataitem(UserSetUp; "User Setup")
                {
                    DataItemLink = "User ID" = FIELD("Approver ID");
                    column(Signature_UserSetup; UserSetUp."User Signature")
                    {
                    }
                    column(ApprovalDesignation_UserSetup; UserSetUp."Approval Title")
                    {
                    }
                }

                trigger OnPreDataItem()
                begin
                    ApprovalEntry.SETRANGE(ApprovalEntry.Status, ApprovalEntry.Status::Approved);
                    ApprovalEntry.SetFilter(ApprovalEntry."Approver ID", '<>%1', "Payments Header".Cashier);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                StrCopyText := '';
                IF "No. Printed" >= 1 THEN BEGIN
                    StrCopyText := 'DUPLICATE';
                END;
                TTotal := 0;


                //Set currcode to Default if blank
                GLSetup.GET();
                IF "Payments Header"."Currency Code" = '' THEN BEGIN
                    CurrCode := GLSetup."LCY Code";
                END ELSE
                    CurrCode := "Payments Header"."Currency Code";

                //For Inv Curr Code
                IF "Payments Header"."Invoice Currency Code" = '' THEN BEGIN
                    InvoiceCurrCode := GLSetup."LCY Code";
                END ELSE
                    InvoiceCurrCode := "Payments Header"."Invoice Currency Code";

                //End;
                DimVal.RESET;
                DimVal.SETRANGE(DimVal.Code, "Payments Header"."Shortcut Dimension 2 Code");
                IF DimVal.FIND('-') THEN BEGIN
                    DptName := DimVal.Name;
                END;
                DimVal.RESET;
                DimVal.SETRANGE(DimVal.Code, "Payments Header"."Shortcut Dimension 3 Code");
                IF DimVal.FIND('-') THEN BEGIN
                    Projectname := DimVal.Name;
                END;
                ApprovalEntry.reset;
                ApprovalEntry.SetRange("Document No.", "Payments Header"."No.");
                ApprovalEntry.SetFilter("Sequence No.", '=%1', 1);
                if ApprovalEntry.FindFirst() then begin
                    Approver1 := ApprovalEntry."Approver ID";
                    AppravalDate1 := (ApprovalEntry."Last Date-Time Modified");
                    UserSetUp.Reset();
                    UserSetUp.setrange("User ID", ApprovalEntry."Approver ID");
                    if UserSetUp.findfirst() then begin
                        UserSetUp.CalcFields("User Signature");
                        Verificationofficer := UserSetUp."Approval Title";


                    end
                end;

                ApprovalEntry.reset;
                ApprovalEntry.SetRange("Document No.", "Payments Header"."No.");
                ApprovalEntry.SetFilter("Sequence No.", '=%1', 2);
                if ApprovalEntry.FindFirst() then begin
                    Approver2 := ApprovalEntry."Approver ID";
                    ApprovalDate2 := (ApprovalEntry."Last Date-Time Modified");
                    UserSetUp.Reset();
                    UserSetUp.setrange("User ID", ApprovalEntry."Approver ID");
                    if UserSetUp.findfirst() then begin
                        UserSetUp.CalcFields("User Signature");
                        ApprovarDestination2 := UserSetUp."Approval Title";


                    end
                end;

                ApprovalEntry.reset;
                ApprovalEntry.SetRange("Document No.", "Payments Header"."No.");
                ApprovalEntry.SetFilter("Sequence No.", '=%1', 3);
                if ApprovalEntry.FindFirst() then begin
                    Approver3 := ApprovalEntry."Approver ID";
                    ApprovalDate3 := (ApprovalEntry."Last Date-Time Modified");
                    UserSetUp.Reset();
                    UserSetUp.setrange("User ID", ApprovalEntry."Approver ID");
                    if UserSetUp.findfirst() then begin
                        UserSetUp.CalcFields("User Signature");
                        ApprovarDestination3 := UserSetUp."Approval Title";


                    end
                end;
                ApprovalEntry.reset;
                ApprovalEntry.SetRange("Document No.", "Payments Header"."No.");
                ApprovalEntry.SetFilter("Sequence No.", '=%1', 4);
                if ApprovalEntry.FindFirst() then begin
                    Approver4 := ApprovalEntry."Approver ID";
                    ApprovalDate4 := (ApprovalEntry."Last Date-Time Modified");
                    UserSetUp.Reset();
                    UserSetUp.setrange("User ID", ApprovalEntry."Approver ID");
                    if UserSetUp.findfirst() then begin
                        UserSetUp.CalcFields("User Signature");
                        ApprovarDestination4 := UserSetUp."Approval Title";



                    end
                end;

                // userSet.get(Cashier);
                // userSet.CalcFields("User Signature");
            end;

            trigger OnPostDataItem()
            begin
                /*
                IF CurrReport.PREVIEW=FALSE THEN
                  BEGIN
                    "No. Printed":="No. Printed" + 1;
                    MODIFY;
                  END;
                  */
                "Payments Header".CALCFIELDS("Payments Header"."Total Net Amount");
                CheckReport.InitTextVariable();
                CheckReport.FormatNoText(NumberText, "Payments Header"."Total Net Amount", '');

            end;

            trigger OnPreDataItem()
            begin

                //LastFieldNo := FIELDNO("No.");
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }
    trigger OnPreReport()
    begin
        company.RESET;
        IF company.FINDFIRST THEN BEGIN
            company.CALCFIELDS(Picture);
        END;
        Users.Reset;
        Users.SetRange(Users."User Name", UserId);
        if Users.Find('-') then begin
            if Users."Full Name" = '' then UserName := Users."User Name" else UserName := Users."Full Name";
        end;
    end;



    var
        userSet: Record "User Setup";
        StrCopyText: Text[250];
        Verificationofficer: TEXT;
        Approver1: code[20];
        Signature2: array[20] of text[50];
        Users: Record User;
        UserName: Text[130];
        Projectname: text[250];

        Approver2: code[20];
        approver3: code[20];
        approver4: code[20];
        ApprovarDestination3: text;
        ApprovarDestination4: text;
        ApprovarDestination2: text;
        ApproverDestination3: text;
        AppravalDate1: DateTime;
        ApprovalDate2: DateTime;
        approvalDate3: DateTime;
        approvalDate4: DateTime;

        SigNature1: Integer;



        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        DimVal: Record 349;
        DimValName: Text[250];
        TTotal: Decimal;
        CheckReport: Report 1401;
        NumberText: array[2] of Text[250];
        STotal: Decimal;
        InvoiceCurrCode: Code[40];
        CurrCode: Code[40];
        GLSetup: Record 98;
        DptName: Code[250];
        company: Record 79;
}

