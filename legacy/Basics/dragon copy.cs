using System;


namespace DragonGame2Sem
{



     

    class Parent {
        public string name = "";
        public int health;
        public int attack;
        public Parent(String name, int health, int attack)
        {
            this.name = name;
            this.health = health;
            this.attack = attack;
        }
    }

    class Hero: Parent {
       // public String name = "";
        static Random rand = new Random();

        public Hero(String name, int health, int attack): base(name, health, attack) {
            this.health = health;
        }

        public int randAttack()
        {
            return rand.Next(1, 100);
        }

        public void hitBy(int randDragon)
        {

            this.health -= randDragon;

            // return health -= rand.Next(0, 100);
        }
    }




    class Dragon: Parent {

        static Random rand = new Random();
       

        public Dragon(String name, int health, int attack) : base(name, health, attack) {
        }
          
        


        public int randAttack() {
            return rand.Next(1, 100);
        }

        public void hitBy(int randHero) {

            this.health -= randHero;

            // return health -= rand.Next(0, 100);
        }
    }



    class MainClass
    {
        public static void Main(string[] args)
        {

            var f = new Hero("Filip", 210, 20);
            var d = new Dragon("Hugo", 230, 20);


            // bool cond = f.health > 0 && d.health > 0;

           

            while (true) {
                int da = d.randAttack();
                int fa = f.randAttack();


                if (d.health - fa > 0)
                {
                    d.hitBy(fa);
                }
                else {
                    d.health = 0;
                }


                if (f.health - da > 0)
                {
                    f.hitBy(da);
                }
                else
                {
                    f.health = 0;
                }




              
                print("Dragon: " + d.health + " Fighter: " + f.health);

                if ((f.health) == 0 || (d.health) == 0)
                {


                    if (f.health == 0)
                    {
                        print("Drak vyhrál");
                    }
                    else {
                        print("Bojovník vyhrál");
                    }
         
                    break;
                } 
                
           
                
                /*  if (f.health > 0 && d.health > 0) {
                      break;
                  }
                  */


            }
        }

        public static void print(String text)
        {
            Console.WriteLine(text);
        }
    }
}
