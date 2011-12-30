module SynchronyRspec
  def append_features(mod)
    mod.class_eval %[
      around(:each) do |example|
        p 'in the around each block'
        EM.synchrony do
          p "in the synchrony run block"
          example.run
          EM.stop
        end
      end
    ]
  end
end
