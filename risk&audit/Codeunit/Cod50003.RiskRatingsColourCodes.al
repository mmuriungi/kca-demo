codeunit 50003 "Risk Ratings Colour Codes"
{
    procedure RiskRatingColours(RisckEVScore: Record "Risk Evaluation Score"): Text[50]
    begin
        with RisckEVScore do
            case "Risk Rating" of
                "Risk Rating"::"VERY HIGH":
                    exit('Attention');
                "Risk Rating"::HIGH:
                    exit('unfavorable');
                "Risk Rating"::"VERY LOW":
                    exit('Favorable');
                "Risk Rating"::LOW:
                    exit('ambiguous');
                "Risk Rating"::MEDIUM:
                    exit('ambiguous');

            end;
    end;

    // procedure RiskScoreColours(RiskScore: Record "Risk Scores Colours"): Text[90]
    // begin
    //     with RiskScore do
    //         case Score of
    //         if  Score=8 then
    //       exit('Attention');
    //         end;
    // end;


}
