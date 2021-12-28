using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Alchemy
{
    public class Rule
    {
        public int RuleID { get; }
        public string Description { get; }
        public HashSet<Fact> Causes { get; }
        public Fact Consequence { get; }



        public Rule(int ruleID, IEnumerable<Fact> causes, Fact consequence, string description)
        {
            RuleID = ruleID;
            Description = description;
            Causes = new HashSet<Fact>();
            foreach (var f in causes)
            {
                Causes.Add(f);
            }
            Consequence = consequence;
        }

        public override int GetHashCode()
        {
            return RuleID.GetHashCode();
        }

        public override bool Equals(object obj)
        {
            if (obj is Rule)
            {
                return RuleID == (obj as Rule).RuleID;
            }
            return false;
        }

        public bool MightBeApplied(HashSet<int> findedFactsID)
        {
            foreach (var fact in Causes)
            {
                if (!findedFactsID.Contains(fact.FactID))
                {
                    return false;
                }
            }
            return true;
        }


        public override string ToString()
        {
            return $@"Rule id: {RuleID}, 
                      description: {Description},
                      {String.Join("; ", Causes.Select(f => f.ToString()).ToArray())} --> {Consequence}";
        }

        public string ToClips()
        {
            return String.Join(Environment.NewLine,  $"(defrule Rule_{RuleID}_A",
                          "\t(declare (salience 40))",
                           "\t"+String.Join("\n\t", Causes.Select((f,i) => f.ToClipsCause(i)).ToArray()),
                          $"\t(not (exists {Consequence.ToClips(false)} ))",
                          "\t=>",
                          $"\t(assert {Consequence.ToClipsConsequence(Causes.Count())})",
                          $"\t(assert(sendmessagehalt \"{Description}|{Consequence.Description}|\"))",
                          "\t(halt)",
                       ")\n") +
                String.Join(Environment.NewLine, $"(defrule Rule_{RuleID}_B",
                    "\t(declare (salience 50))",
                    "\t" + String.Join("\n\t", Causes.Select((f, i) => f.ToClipsCause(i)).ToArray()),
                    $"\t?f<-{Consequence.ToClipsModify()}",
                    $"\t?newA<-{Fact.AssuranceMultiplyString(Causes.Count())}",
                    "\t(< ?a ?newA)",
                    "\t=>",
                    $"\t(modify ?f (assurance ?newA))",
                   "\t(halt)",
                    ")");
        }

    }
}
