module ProductsHelper
  def product_description(product)
    if product.description == nil
      return ("No description.").html_safe
    else
      return (product.description).html_safe
    end
  end
end
