using CLIPSNET;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace Alchemy
{
    public partial class Form1 : Form
    {
        const string AlchemyPath = "../../alchemy.clp";
        const string AlchemyBasePath = "../../alchemy_base.clp";
        const string FactsPath = "..//..//facts.txt";
        const string RulesPath = "..//..//rules.txt";

        private Dictionary<int, Fact> facts;
        private IEnumerable<Rule> rules;
        private Dictionary<int, Fact> initialFacts;
        private Dictionary<int, Fact> terminals;
        private Dictionary<string, bool> finded;
        private Dictionary<int, double> assurance;

        CLIPSNET.Environment clips = new CLIPSNET.Environment();
       
        public Form1()
        {
            InitializeComponent();
            facts = Parser.ParseFacts(FactsPath).ToDictionary(f=>f.FactID, f=>f);
            rules = Parser.ParseRules(RulesPath, facts);
            initClipsRules();
            initialFacts = new Dictionary<int, Fact>();
            terminals = new Dictionary<int, Fact>();
            finded = new Dictionary<string, bool>();
            assurance = new Dictionary<int, double>();
            addInitialFact(1);
            addInitialFact(2);
            addInitialFact(3);
            addInitialFact(4);
            load();
        }

        /// <summary>
        /// добавить правила в нужном формате в файл CLIPS  
        /// </summary>
        private void initClipsRules()
        {
            var clipsBaseText = File.ReadAllText(AlchemyBasePath, Encoding.UTF8);
            var stringBuilder = new StringBuilder(clipsBaseText);
            foreach(var r in rules)
            {
                stringBuilder.Append(r.ToClips());
                stringBuilder.Append("\n\n");
            }
            File.WriteAllText(AlchemyPath, stringBuilder.ToString(), Encoding.UTF8);
        }

        /// <summary>
        /// Загрузить факты в списки
        /// </summary>
        private void load()
        {
            foreach (var fact in facts.Values)
            {
                
               allFactsListBox.Items.Add(fact.ToListItem(false));           
            }
        }

        /// <summary>
        /// достает id файла из строки в списке
        /// </summary>
        private int parseFactID(string str)
        {
            return int.Parse(str.Split('.')[0]);
        }

        /// <summary>
        /// добавление начального фактов
        /// </summary>
        /// <param name="factID">id факта - ключ в facts</param>
        private void addInitialFact(int factID)
        {
            if (initialFacts.ContainsKey(factID))
                return;
            var fact = facts[factID];
            initialFacts[factID] = fact;
            initialFactsListBox.Items.Add(fact.ToListItem());
        }

        /// <summary>
        /// добавление терминала
        /// </summary>
        /// <param name="factID">id факта - ключ в facts</param>
        private void addTerminal(int factID)
        {
            if (terminals.ContainsKey(factID))
                return;
            start.Enabled = true;
            var fact = facts[factID];
            terminals[factID] = fact;
            terminalsListBox.Items.Add(fact.ToListItem(false));
        }

        /// <summary>
        /// Добавить заданные факты в CLIPS
        /// </summary>
        private void addFactsToClips()
        {
            foreach (var fact in initialFacts.Values)
            {
                clips.Eval($"(assert {fact.ToClips()})");
                textBox2.Text += $"Добавлен исхоный факт {fact.ToListItem()}" + System.Environment.NewLine;
            }
        }

        /// <summary>
        /// Обработать полученное сообщение от CLIPS
        /// </summary>
        private void handleMessage(string message)
        {
            textBox2.Text += message + System.Environment.NewLine;
        }

        /// <summary>
        /// Выполнить шаг вывода в CLIPS
        /// </summary>
        private bool nextStep()
        {
            clips.Run();
            var facts = clips.GetFactList();
            try
            {
                var fact = facts.First(f => f.RelationName == "sendmessagehalt");
                var factValues = fact.GetSlotValues()[0].Contents.Replace("\"", "").Split('|');
                var ruleDescription = factValues[0].Substring(1);
                
                handleMessage(ruleDescription);
                clips.Eval("(assert (clearmessage))");
            }
            catch (InvalidOperationException)
            {
                MessageBox.Show($"Всё! Не вывели: {string.Join(", ",finded.Where(p=>!p.Value).Select(p=>p.Key).ToArray())}");
                return false;
            }
            foreach (var fact in facts.Where(f=>f.RelationName=="fact"))
            {
               
                var f = new Fact(fact.GetSlotValues());
                if (finded.ContainsKey(f.Description)&&finded[f.Description]==false)
                {
                    finded[f.Description] = true;
                    MessageBox.Show($"Вывели терминал: {f.ToListItem()}!");
                }
                if (!assurance.ContainsKey(f.FactID))
                {
                    assurance[f.FactID] = f.Assurance;
                    handleMessage($"Получен факт: {f.ToListItem()}" + System.Environment.NewLine);
                }
                else
                {
                    if (assurance[f.FactID] != f.Assurance)
                    {
                        assurance[f.FactID] = f.Assurance;
                        handleMessage($"Получен факт: {f.ToListItem()}"+ System.Environment.NewLine);
                    }
                }
            }
            return true;
        }

        /// <summary>
        /// добавляем факт в терминалы при двойном щелчке
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void allFactsListBox_MouseDoubleClick(object sender, MouseEventArgs e)
        {
            if (allFactsListBox.SelectedItem == null) return;
            addTerminal(parseFactID(allFactsListBox.SelectedItem.ToString()));
        }

        /// <summary>
        /// добавляем факт в начальные при нажатии пробела
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void allFactsListBox_KeyDown(object sender, KeyEventArgs e)
        {
            if (allFactsListBox.SelectedItem == null) return;
            if (e.KeyCode == Keys.Space)
            {
                addInitialFact(parseFactID(allFactsListBox.SelectedItem.ToString()));
            }
        }
        
        /// <summary>
        /// удаляем факт из начальных при двойном щелчке по нему
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void initialFactsListBox_MouseDoubleClick(object sender, MouseEventArgs e)
        {
            if (initialFactsListBox.SelectedItem == null) return;
            initialFacts.Remove(parseFactID(initialFactsListBox.SelectedItem.ToString()));
            initialFactsListBox.Items.Remove(initialFactsListBox.SelectedItem);
        }

        /// <summary>
        /// удаляем начальный факт из терминалов при двойном щелчке по нему
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void terminalsListBox_MouseDoubleClick(object sender, MouseEventArgs e)
        {
            if (terminalsListBox.SelectedItem == null) return;
            terminals.Remove(parseFactID(terminalsListBox.SelectedItem.ToString()));
            terminalsListBox.Items.Remove(terminalsListBox.SelectedItem);
            if (terminals.Count == 0)
            {
                start.Enabled = false;
            }
        }

        /// <summary>
        /// запуск CLIPS
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void start_Click(object sender, EventArgs e)
        {
            textBox2.Text = "";
            clips.Clear();
            clips.LoadFromString(File.ReadAllText(AlchemyPath));
            //получаем список введенных правил
            addFactsToClips();
            finded.Clear();
            foreach(var f in terminals)
            {
                finded[f.Value.Description] = false;
            }
            assurance.Clear();
            foreach (var f in initialFacts.Values)
            {
                assurance[f.FactID] = f.Assurance;
            }
            next.Enabled = true;
            allButton.Enabled = true;
        }

        /// <summary>
        /// следующий шаг CLIPS
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void next_Click(object sender, EventArgs e)
        {
            nextStep();
        }

        private void allButton_Click(object sender, EventArgs e)
        {
            while (nextStep());
        }

        private void initialFactsListBox_KeyDown(object sender, KeyEventArgs e)
        {
            if (initialFactsListBox.SelectedItem == null) return;
            if (e.KeyCode == Keys.Space)
            {
                SelectAssuranceDialog selectAssuranceDialog = new SelectAssuranceDialog();
                if (selectAssuranceDialog.ShowDialog() == DialogResult.OK)
                {
                    facts[parseFactID(initialFactsListBox.SelectedItem.ToString())].Assurance =
                        selectAssuranceDialog.Assurance;
                    initialFactsListBox.Items.Clear();
                    foreach (var fact in initialFacts.Values)
                    {
                        initialFactsListBox.Items.Add(fact.ToListItem());
                    }
                    
                }
            }
        }
    }
}
