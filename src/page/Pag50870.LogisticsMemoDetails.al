page 50870 "Logistics Memo Details"
{
    PageType = List;
    SourceTable = "FIN-Memo Details";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Type; Rec.Type)
                {
                    Editable = false;
                }
                field("Expense Code"; Rec."Expense Code")
                {
                    Editable = false;
                    Enabled = false;
                }
                field("Payee Type"; Rec."Payee Type")
                {
                    trigger OnValidate()
                    var
                        ImpHeader: Record "FIN-Memo Header";
                    begin
                        if Rec."Payee Type" = Rec."Payee Type"::Staff then begin
                            ImpHeader.Reset();
                            ImpHeader.SetRange("No.", Rec."Memo No.");
                            if ImpHeader.Find('-') then begin
                                Rec."Staff no." := ImpHeader."Memo Requestor No";
                                Rec."Staff Name" := ImpHeader."To";
                            end;
                        end;
                    end;
                }
                field("Staff no."; Rec."Staff no.")
                {
                    Editable = false;
                }
                field("Vehicle No"; Rec."Vehicle No")
                {

                }
                field("Fuel Consumption Rate"; Rec."Consumption Rate")
                {
                    Editable = false;
                }
                field("Fuel Rate"; Rec."Fuel Rate")
                {
                    Editable = false;
                }
                field(Distance; Rec.Distance)
                {

                }

                field(Amount; Rec.Amount)
                {
                    Editable = false;
                    Enabled = false;
                }


            }
        }
    }

    actions
    {
    }
}