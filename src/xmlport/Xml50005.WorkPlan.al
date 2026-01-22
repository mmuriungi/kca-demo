xmlport 50005 WorkPlan
{
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("Workplan Activities"; "Workplan Activities")
            {
                XmlName = 'WorkPlan';
                fieldelement(a; "Workplan Activities"."Workplan Code")
                {
                }
                fieldelement(b; "Workplan Activities"."Activity Code")
                {
                }
                fieldelement(c; "Workplan Activities"."Activity Description")
                {
                }
                fieldelement(d; "Workplan Activities"."Account Type")
                {
                }
                fieldelement(e; "Workplan Activities".Type)
                {
                }
                fieldelement(m; "Workplan Activities"."Expense Code")
                {
                    MinOccurs = Zero;
                }
                fieldelement(g; "Workplan Activities"."No.")
                {
                }
                fieldelement(i; "Workplan Activities"."Global Dimension 1 Code")
                {
                }
                //fieldelement(j;"Workplan Activities"."Global Dimesnsion 2 Code")

                fieldelement(k; "Workplan Activities"."Proc. Method No.")
                {
                }
                fieldelement(l; "Workplan Activities".Quantity)
                {
                }
                fieldelement(n; "Workplan Activities"."Amount To Transfer")
                {
                    MinOccurs = Zero;
                }

                trigger OnAfterInsertRecord()
                begin
                    /*
                    "Workplan Activities"."Uploaded to Procurement Workpl" := TRUE;
                    "Workplan Activities".MODIFY;
                    */

                end;
            }
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
}

