report 53053 "Food Receipt"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Food Receipt.rdl';

    dataset
    {
        dataitem("CAT-Menu Sale Header"; "CAT-Menu Sale Header")
        {
            column(Menu_Sale_Header__Sales_Point_; "Sales Point")
            {
            }
            column(Reg; Reg)
            {
            }
            column(Compname; info.Name)
            {

            }
            column(comppik; info.Picture)
            {

            }
            column(compmail; info."E-Mail")
            {

            }
            column(Menu_Sale_Header__Receipt_No_; "Receipt No")
            {
            }
            column(Menu_Sale_Header__Paid_Amount_; "Paid Amount")
            {
            }
            column(Menu_Sale_Header_Balance; Balance)
            {
            }
            column(Menu_Sale_Header__Cashier_Name_; "Cashier Name")
            {
            }

            column(CALL_AGAINCaption; CALL_AGAINCaptionLbl)
            {
            }
            column(REG_Caption; REG_CaptionLbl)
            {
            }
            column(Menu_Sale_Header__Paid_Amount_Caption; FieldCaption("Paid Amount"))
            {
            }
            column(PrepBalBef; PrepBalAf)
            {
            }
            column(PrepBalAf; PrepBalBef)
            {
            }
            column(Secur; SecFo)
            {
            }
            column(Menu_Sale_Header_BalanceCaption; FieldCaption(Balance))
            {
            }
            column(SalesType; "CAT-Menu Sale Header"."Sales Type")
            {
            }
            column(Date_Menu; "CAT-Menu Sale Header".Date)
            {

            }
            column(CustomerNo; "CAT-Menu Sale Header"."Customer No")
            {
            }
            dataitem("CAT-Menu Sales Line"; "CAT-Menu Sales Line")
            {
                DataItemLink = "Receipt No" = FIELD("Receipt No");
                DataItemTableView = SORTING("Line No", "Receipt No") ORDER(Ascending);
                column(Menu_Sales_Line__Unit_Cost_; "Unit Cost")
                {
                }
                column(Menu_Sales_Line_Quantity; Quantity)
                {
                }
                column(Menu_Sales_Line_Amount; Amount)
                {
                }
                column(Menu_Sales_Line_Description; Description)
                {
                }
                column(Menu_Sales_Line_Amount_Control1000000012; Amount)
                {
                }
                column(TotalCaption; TotalCaptionLbl)
                {
                }
                column(Menu_Sales_Line_Line_No; "Line No")
                {
                }
                column(Menu_Sales_Line_Menu; Menu)
                {
                }
                column(Menu_Sales_Line_Receipt_No; "Receipt No")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                "CAT-Menu Sale Header".CalcFields("CAT-Menu Sale Header"."Prepayment Balance");
                "CAT-Menu Sale Header".CalcFields("CAT-Menu Sale Header".Amount);
                //calcfields(picture);
                PrepBalBef := "CAT-Menu Sale Header"."Prepayment Balance";
                if PrepBalBef <> 0 then
                    PrepBalAf := "CAT-Menu Sale Header"."Prepayment Balance" - "CAT-Menu Sale Header".Amount;

                Sec := 010101T - Time;
                SecFo := Format(Sec);
                "CAT-Menu Sale Header"."Last Sc" := Format(Sec);
                "CAT-Menu Sale Header".Modify;
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

    var
        Reg: Code[20];
        CHUKACaptionLbl: Label 'CHUKA';
        UNIVERSITYCaptionLbl: Label 'UNIVERSITY';
        CALL_AGAINCaptionLbl: Label 'CALL AGAIN';
        REG_CaptionLbl: Label 'REG:';
        TotalCaptionLbl: Label 'Total';
        PrepBalBef: Decimal;
        PrepBalAf: Decimal;
        Sec: Integer;
        SecFo: Text;
        info: record "Company Information";
}

