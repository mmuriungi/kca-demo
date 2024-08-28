xmlport 50010 "Import KUCCPS Students"
{
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("Text kuccps jab"; "KUCCPS Imports")
            {
                AutoUpdate = true;
                XmlName = 'Textkuccpsjab';
                fieldelement(a; "Text KUCCPS Jab".ser)
                {
                }


                fieldelement(c; "Text KUCCPS Jab".Index)
                {
                }
                fieldelement(o; "Text KUCCPS Jab".Admin)
                {

                }
                fieldelement(b; "Text KUCCPS Jab"."Student No")
                {
                }
                fieldelement(d; "Text KUCCPS Jab".Names)
                {
                }
                fieldelement(e; "Text KUCCPS Jab".Gender)
                {
                }
                fieldelement(f; "Text KUCCPS Jab".Phone)
                {
                    MinOccurs = Zero;
                }
                fieldelement(g; "Text KUCCPS Jab"."Alt. Phone")
                {
                    MinOccurs = Zero;
                }
                fieldelement(h; "Text KUCCPS Jab".Email)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                fieldelement(i; "Text KUCCPS Jab"."Slt Mail")
                {
                    MinOccurs = Zero;
                }
                fieldelement(j; "Text KUCCPS Jab".Box)
                {
                    MinOccurs = Once;
                }
                fieldelement(k; "Text KUCCPS Jab".Codes)
                {
                    MinOccurs = Zero;
                }
                fieldelement(l; "Text KUCCPS Jab".Town)
                {
                    MinOccurs = Once;
                }
                fieldelement(m; "Text KUCCPS Jab".Prog)
                {
                }
                fieldelement(n; "Text KUCCPS Jab"."Any Other Institution Attended")
                {
                    MinOccurs = Zero;
                    MaxOccurs = Once;
                }
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

