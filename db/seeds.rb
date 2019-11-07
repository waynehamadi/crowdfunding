if Rails.env.development?
  # Destroy All
  Project.destroy_all
  Category.destroy_all
  AdminUser.destroy_all
  User.destroy_all
  # Admins
  AdminUser.create!(email: 'admin1@capsens.eu', password: 'password1', password_confirmation: 'password1') if Rails.env.development?
  AdminUser.create!(email: 'admin2@capsens.eu', password: 'password2', password_confirmation: 'password2') if Rails.env.development?
  AdminUser.create!(email: 'admin3@capsens.eu', password: 'password3', password_confirmation: 'password3') if Rails.env.development?
  User.create!(first_name: "first_name1", last_name:"last_name2", birth_date:"12-01-1993",email: 'user1@capsens.eu', password: 'password1', password_confirmation: 'password1') if Rails.env.development?
  # Categories

  agriculture = Category.new(name: "agriculture")
  agriculture.save
  alimentation = Category.new(name: "alimentation")
  alimentation.save

  energie = Category.new(name: "énergie")
  energie.save

  sante = Category.new(name: "santé")
  sante.save

  egalite = Category.new(name: "égalité")
  egalite.save

  environnement = Category.new(name: "environnement")
  environnement.save

  education = Category.new(name: "éducation")
  education.save

  logement = Category.new(name: "logement")
  logement.save

  # Projects

  solifap = Project.create(
    name: "Solifap",
    short_description: "Société d’investissements solidaires de la fondation Abbé Pierre qui utilise l’épargne citoyenne comme une réponse concrète à la lutte contre le mal-logement. ",
    long_description: "Parce que bénéficier d'un logement c'est reconstruire une vie, Solifap est une société d'investissements solidaires qui soutient les associations luttant contre le mal-logement. Plus de 60 ans après « l’appel à l'insurrection de la bonté » de l’Abbé Pierre, la situation du mal-logement en France reste encore une préoccupation majeure pour 12 millions de français. La Fondation Abbé Pierre, qui a pour mission de permettre à toute personne démunie d'accéder à un logement décent et à une vie digne, décide ainsi de créer Solifap en 2014 pour déployer des moyens additionnels pour lutter contre le mal-logement, en s’appuyant sur l’épargne citoyenne. Solifap permet à l’épargne des citoyens de devenir un levier d’action direct afin de soutenir les associations qui luttent contre le mal logement, en augmentant leur capacité à produire des offres de logements très sociaux, en garantissant leur développement financier et en améliorant l'efficacité de leur modèle socio-économique. Solifap est titulaire du label Finansol garantissant la transparence et le caractère solidaire du produit financier qu’elle propose.",
    goal_amount: 70000,
    category: egalite
    )
  bioburger = Project.create(
    name: "Bioburger",
    short_description: "Premier fast-food 100% bio qui change tous les codes de la restauration rapide. ",
    long_description: "Fondé en 2011 par deux jeunes entrepreneurs passionnés de culture food, Bioburger a pour ambition de changer les codes du fast-food et surtout promouvoir et démocratiser l’agriculture biologique d’une manière différente grâce à un plat aimé de tous : le hamburger. Bioburger est, depuis sa création, l’unique enseigne de restauration rapide 100% bio spécialisée dans le burger gourmet pour carnivores et végétariens. Défendant des valeurs similaires pour développer et démocratiser l’agriculture biologique, la coopérative Biocoop se rapproche de Bioburger en 2018 et en devient actionnaire minoritaire. Développée en franchise depuis 2017 (1 restaurant à date), l’enseigne Bioburger compte à ce jour 4 restaurants en activité répartis entre Paris et La Défense. Bioburger a pour objectif l’ouverture de 30 restaurants d'ici fin 2022, dont 80% en franchises et le reste en succursales.",
    goal_amount: 133000,
    category: alimentation
    )
  ecomegot = Project.create(
    name: "Ecomegot",
    short_description: "Une solution complète, professionnelle et locale de sensibilisation, collecte et valorisation de mégots de cigarette pour les acteurs privés et publics",
    long_description: "ÉcoMégot propose une solution complète, professionnelle et locale de sensibilisation, collecte et valorisation de mégots de cigarette pour les acteurs privés et publics. Le projet est né au début de l’année 2016, suite à la prise de conscience d’Erwin Faure, son fondateur : aucune solution de dépollution et de recyclage viable des mégots n’existait en France. Inspiré par des initiatives développées à l’étranger, ÉcoMégot a développé une solution innovante mettant en symbiose économie circulaire, emplois locaux et filière de recyclage locale. 100% français, 100% artisanaux et 100% résistants : ÉcoMégot accompagne tous les volontaires, tous secteurs confondus, dans la création de leur propre espace zéro mégot. Le mégot, ce petit déchet polluant tristement fondu dans le paysage urbain, peut devenir une ressource économique et un acteur social. C’est tout le pari lancé par ÉcoMégot !",
    goal_amount: 200000,
    category: sante
    )
end
