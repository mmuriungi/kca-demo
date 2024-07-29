page 50876 "PRN Memo Header"
{
    CardPageID = "FIN-Memo Header Card";
    PageType = List;
    SourceTable = "FIN-Memo Header";
    SourceTableView = WHERE(PRN = filter(true), "Memo Status" = CONST(Approved));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                }
                field("Date/Time"; Rec."Date/Time")
                {
                }
                field(From; Rec.From)
                {
                }
                field(Through; Rec.Through)
                {
                }
                field("To"; Rec."To")
                {
                }
                field("PRN No."; Rec."PRN No.")
                {
                    Editable = false;
                    Enabled = false;
                }
                field("Created by"; Rec."Created by")
                {
                }
                field("Payroll Period"; Rec."Payroll Period")
                {
                }
                field("Period Month"; Rec."Period Month")
                {
                }
                field("Period Year"; Rec."Period Year")
                {
                }
                field("Memo Status"; Rec."Memo Status")
                {
                }
            }
        }
    }

    actions
    {
    }
}

